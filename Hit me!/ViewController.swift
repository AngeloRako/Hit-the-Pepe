//
//  ViewController.swift
//  Hit me!
//
//  Created by Angelo Rako on 24/10/2016.
//  Copyright © 2016 Angelo Rako. All rights reserved.
//

import UIKit

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
    var moneyPerTap:Double = 0.5
    var achievement = [Bool](repeating: false, count: 10)
    var timer = Timer()
    var playing = false
    var randomQuotes:[String] = []
    
    func Init()
    {
        Match = Game(ScorePerTap: 0.5, Button: littleGuy)
        
        restartBtn.setFAText(prefixText: "", icon: FAType.FARefresh, postfixText: "", size: 20)
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
        
        Match!.MoveButton()
    }
    
    @IBAction func touched(_ sender: AnyObject)
    {
        if let Game = Match
        {
            if (!Game.Started)
            {
                StartTimer()
                
                Game.Started = true
            }
            
            score.text = "$\(Game.UpdateScore())"
            
            littleGuy.isSelected = true
            littleGuy.isUserInteractionEnabled = false
            
            quote.text = Game.GetQuote()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1)
            {
                self.littleGuy.isSelected = false
                self.littleGuy.isUserInteractionEnabled = true
            }
        }
        
        
        
        
        /*
        if(!playing)
        {
            playing = true
            interval = 1.0
            moneyPerTap = 0.5
            timer.invalidate()
            currentTime.text = "00:00"
            score.text = "$0"
            
            startTimer()
        }
        
        randomizePos()
        
        score.text!.remove(at: score.text!.startIndex)
        
        score.text = "$" + String(Double(score.text!)! + moneyPerTap)
        
        //Random quotes
        var randomIndex = Int(arc4random_uniform(UInt32(randomQuotes.count)))
        
        while(quote.text == randomQuotes[randomIndex])
        {
            randomIndex = Int(arc4random_uniform(UInt32(randomQuotes.count)))
        }
        quote.text = randomQuotes[randomIndex]
        
        
        //Achievement control
        let value = score.text!.characters.dropFirst()
        
        if((Double(String(value)))! >= 10.0 && achievement[0] == false){
            moneyPerTap*=2
            quote.text = "LEVEL UP! This is just the beginning!"
            achievement[0] = true
            littleGuy.setImage(UIImage(named: "default.jpg"), for: .normal)
        }
        
        if((Double(String(value)))! >= 100.0 && achievement[1] == false){
            moneyPerTap*=2
            quote.text = "LEVEL UP! Money is coming!"
            achievement[1] = true
            littleGuy.setImage(UIImage(named: "moneyPepe.png"), for: .normal)

        }
        
        if((Double(String(value)))! >= 500.0 && achievement[2] == false){
            moneyPerTap*=2
            quote.text = "LEVEL UP! I see you're getting rich!"
            achievement[2] = true
            littleGuy.setImage(UIImage(named: "richPepe.jpg"), for: .normal)

        }
       
        if((Double(String(value)))! >= 1000.0 && achievement[3] == false){
            moneyPerTap*=2
            quote.text = "LEVEL UP! This is just the beginning!"
            achievement[3] = true

        }
        */
        
    }
    
    @IBAction func restart(_ sender: AnyObject)
    {
        timer.invalidate()
        interval = 1.0
        
        if(score.text! == "$0.0")
        {
            quote.text = "Tap on Pepe to earn money!"
        }
        else
        {
            let time = currentTime.text!.components(separatedBy: ":")
            quote.text = "You earned \(score.text!) in \((time[0] != "00") ? "\(time[0]) minutes and " : "")\(time[1]) seconds"
            playing = false
        }
    }

}

