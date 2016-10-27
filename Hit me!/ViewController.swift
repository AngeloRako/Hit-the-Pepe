//
//  ViewController.swift
//  Hit me!
//
//  Created by Angelo Rako on 24/10/2016.
//  Copyright © 2016 Angelo Rako. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var playboard: UIView!
    @IBOutlet weak var littleGuy: UIButton!
    @IBOutlet weak var quote: UILabel!
    @IBOutlet weak var restartBtn: UIBarButtonItem!
    
    var interval : TimeInterval = 1.00

    
    
    
    var moneyPerTap: Double = 0.5
    var achievement = [Bool](repeating: false, count: 10)
    var timer = Timer()
    var playing = false
    var randomQuotes = ["Rich pepe is best pepe",
                        "<3 <3 <3",
                        "I like trains. For real. And money",
                        "I like it when you cash it",
                        "Don't stop earning!",
                        "Cash is pawa",
                        "Poor people are poor.",
                        "Do you like frogs? I like rich frogs.",
                        "Horses are bad people who don't pay taxes!",
                        "Molisn't.",
                        "Stop hitting me! Just pat me gently.",
                        "Hell yeah!",
                        "Alex likes me, but he won't admit it",
                        "Get rich!",
                        "Get rekt! Money is gud.",
                        "Rich frogs are rich.",
                        "How do you call rich pepe? GOOD PEPE",
                        "Don't give up on your money",
                        "I like it when you push me",
                        "Did you say money?",
                        "Get that cash!",
                        "Hit me pepe one more time!",
                        "Pepe is a bit richer now",
                        "Don't get rickrolled!",
                        "Pepe is love, money is life",
                        "Gimme dat cash",
                        "I don't pay taxes but I'm not a horse!",
                        "Money makes the world go pepe",
                        "A little money never hurt any pepe",
                        "Say hello to our new life",
                        "Get rich, get pepe",
                        "Gimme dat money!",
                        "Cash is cool, but pepe is cooler.",
                        "Pepe like money.",
                        "Leeroy PEPEEEE"
                        ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        littleGuy.setImage(UIImage(named: "dollarPepe.jpeg"), for: .highlighted)
        restartBtn.setFAText(prefixText: "", icon: FAType.FARefresh, postfixText: "", size: 20)
       // formatter.dateFormat = "mm:ss"
        

        
}
    func startTimer() {
        
        timer = Timer.scheduledTimer(timeInterval:interval, target: self, selector: #selector(tickTock), userInfo: nil, repeats: true)
    }
    
    
    func tickTock() {
        
        interval+=1
        let minutes = Int(interval/60)
        let seconds = Int(interval-Double(minutes)*60.0)
        currentTime.text = String(format: "%02d:%02d", minutes, seconds)
        randomizePos()
        
    }
    
    func randomizePos() {
        // Find the button's width and height
        let buttonWidth = littleGuy.frame.width
        let buttonHeight = littleGuy.frame.height
        
        // Find the width and height of the enclosing view
        let viewWidth = littleGuy.superview!.bounds.width
        let viewHeight = littleGuy.superview!.bounds.height
        
        // Compute width and height of the area to contain the button's center
        let xwidth = viewWidth - buttonWidth
        let yheight = viewHeight - buttonHeight
        
        // Generate a random x and y offset
        let xoffset = CGFloat(arc4random_uniform(UInt32(xwidth)))
        let yoffset = CGFloat(arc4random_uniform(UInt32(yheight)))
        
        // Offset the button's center by the random offsets.
        littleGuy.center.x = xoffset + buttonWidth / 2
        littleGuy.center.y = yoffset + buttonHeight / 2

    }
    
    
    
    @IBAction func touched(_ sender: AnyObject) {
        
        if(!playing){
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
        while(quote.text == randomQuotes[randomIndex]){
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
        
        
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        randomizePos()
    }
    
    @IBAction func restart(_ sender: AnyObject) {
        timer.invalidate()
        interval = 1.0
        if(score.text! == "$0.0"){
            quote.text = "Tap on Pepe to earn money!"
        }
        else{
            let time = currentTime.text!.components(separatedBy: ":")
            quote.text = "You earned \(score.text!) in \((time[0] != "00") ? "\(time[0]) minutes and " : "")\(time[1]) seconds"
            playing = false
        }
    }

}

