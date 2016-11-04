//
//  ViewController.swift
//  Hit me!
//
//  Created by Angelo Rako on 24/10/2016.
//  Copyright © 2016 Angelo Rako. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController
{
    override func viewDidLayoutSubviews()
    {
        Match?.UpdateBounds(Bounds: playboard.bounds.size)
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation)
    {
        Match?.MoveButton()
    }
    
    
    // Outlets
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var playboard: UIView!
    @IBOutlet weak var littleGuy: UIButton!
    @IBOutlet weak var quote: UILabel!
    @IBOutlet weak var restartBtn: UIBarButtonItem!
    
    var Match:Game?
    
    // Variables
    var interval:TimeInterval = 1.00
    //var moneyPerTap:Double = 0.5
    //var achievement = [Bool](repeating: false, count: 10)
    var timer = Timer()
    var moveTick = Timer()
    var bgMusic = AVAudioPlayer()
    var cashSound = AVAudioPlayer()

    //var playing = false
    
    
    func Init()
    {
        Match = Game(ScorePerTap: 0.5, Button: littleGuy)
        
        restartBtn.setFAText(prefixText: "", icon: FAType.FARefresh, postfixText: "", size: 15)
        
        //start sound loop
        do{
            bgMusic = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "dirty_loop", ofType: "mp3")!))
            bgMusic.numberOfLoops = -1
            bgMusic.prepareToPlay()
            
            cashSound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "cash", ofType: "mp3")!))
            cashSound.prepareToPlay()
        }
        catch{
            print(error)
        }

    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        Init()
        
    }
    
    func StartTimer()
    {
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.TicToc), userInfo: nil, repeats: true)
    }
    
    func TicToc()
    {
        interval+=1
        let minutes = Int(interval/60)
        let seconds = Int(interval-Double(minutes)*60.0)
        currentTime.text = String(format: "%02d:%02d", minutes, seconds)
        
        //Match!.MoveButton()
    }
    
    func StartMover(interval: TimeInterval)
    {
        moveTick.invalidate()
        
        moveTick = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(self.move), userInfo: nil, repeats: true)
    }
    
    func move()
    {
        Match!.MoveButton()
    }

    @IBAction func touched(_ sender: AnyObject)
    {
        
        if let Game = Match
        {
            if (!Game.Started)
            {
                score.text = "$0.0"
                StartTimer()
                StartMover(interval: 0.01)
                Game.Started = true
                bgMusic.play()
                
            }
            
            cashSound.currentTime = 0
            
            cashSound.play()

            score.text = "$\(Game.UpdateScore())"
            
            littleGuy.isSelected = true
            littleGuy.isUserInteractionEnabled = false
            
            quote.text = Game.GetQuote()
            
            moveTick.invalidate()
            StartMover(interval: (Match?.moveFrequency)!)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.6)
            {
                self.littleGuy.isSelected = false
                self.littleGuy.isUserInteractionEnabled = true
            }
        }
        
        
        
 
    }
    
    @IBAction func restart(_ sender: AnyObject)
    {
        
        if(Match == nil || Match?.Score == 0.0)
        {
            //if there is no match, invite the user to press on pepe
            quote.text = "Tap on Pepe to earn money!"
        }
        else
        {
            //Stop game
            bgMusic.stop()
            timer.invalidate()
            moveTick.invalidate()
            interval = 1.0
            let time = currentTime.text!.components(separatedBy: ":")
            quote.text = "You earned \(score.text!) in \((time[0] != "00") ? "\(time[0]) minutes and " : "")\(time[1]) seconds"
            Match = Game(ScorePerTap: 0.5, Button: littleGuy)
            Match?.Started = false
        }
    }

}

