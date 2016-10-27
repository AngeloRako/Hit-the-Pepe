//
//  Game.swift
//  Hit me!
//
//  Created by Alexandro Luongo on 27/10/16.
//  Copyright © 2016 Angelo Rako. All rights reserved.
//

import UIKit
import Foundation

class Game
{
    var Started:Bool
    var Button:UIButton
    
    var Score:Double
    var ScorePerTap:Double
    
    var Bounds = CGSize()
    
    var Quotes:[String] = []
    var Achievements:[Achievement] = []
    
    init(ScorePerTap:Double, Button:UIButton)
    {
        Score = 0
        Started = false
        
        self.Button = Button
        self.ScorePerTap = ScorePerTap
        
        InitQuotes()
        
        InitAchievements()
        
        UpdateButton(Image: "sadpepe.jpg", State: .normal)
        UpdateButton(Image: "dollarPepe.jpeg", State: .selected)
    }
    
    func InitQuotes()
    {
        Quotes.append("Rich pepe is best pepe")
        Quotes.append("<3 <3 <3")
        Quotes.append("I like trains. For real. And money")
        Quotes.append("I like it when you cash it")
        Quotes.append("Don't stop earning!")
        Quotes.append("Cash is pawa")
        Quotes.append("Poor people are poor.")
        Quotes.append("Do you like frogs? I like rich frogs.")
        Quotes.append("Horses are bad people who don't pay taxes!")
        Quotes.append("Molisn't.")
        Quotes.append("Stop hitting me! Just pat me gently.")
        Quotes.append("Hell yeah!")
        Quotes.append("Alex likes me, but he won't admit it")
        Quotes.append("Get rich!")
        Quotes.append("Get rekt! Money is gud.")
        Quotes.append("Rich frogs are rich.")
        Quotes.append("How do you call rich pepe? GOOD PEPE")
        Quotes.append("Don't give up on your money")
        Quotes.append("I like it when you push me")
        Quotes.append("Did you say money?")
        Quotes.append("Get that cash!")
        Quotes.append("Hit me pepe one more time!")
        Quotes.append("Pepe is a bit richer now")
        Quotes.append("Don't get rickrolled!")
        Quotes.append("Pepe is love, money is life")
        Quotes.append("Gimme dat cash")
        Quotes.append("I don't pay taxes but I'm not a horse!")
        Quotes.append("Money makes the world go pepe")
        Quotes.append("A little money never hurt any pepe")
        Quotes.append("Say hello to our new life")
        Quotes.append("Get rich, get pepe")
        Quotes.append("Gimme dat money!")
        Quotes.append("Cash is cool, but pepe is cooler.")
        Quotes.append("Pepe like money.")
        Quotes.append("Leeroy PEPEEEE")
    }
    
    func InitAchievements()
    {
        Achievements.append(Achievement(Name: "Not poor", Description: "You're not poor anymore!", Image:"default.jpg", Points: 10, Multiplier:2, Obtained: false))
        /*Achievements.append(Achievement(Name: "2", Description: "2", Image:"", Points: 1, Multiplier:0, Obtained: false))
        Achievements.append(Achievement(Name: "3", Description: "3", Image:"", Points: 1, Multiplier:0, Obtained: false))
        Achievements.append(Achievement(Name: "4", Description: "4", Image:"", Points: 1, Multiplier:0, Obtained: false))*/
    }
    
    func UpdateScore() -> Double
    {
        Score += ScorePerTap
        
        return Score
    }
    
    func UpdateBounds(Bounds:CGSize)
    {
        self.Bounds = Bounds
    }
    
    func UpdateButton(Image:String, State:UIControlState)
    {
        Button.setImage(UIImage(named: Image), for: State)
    }
    
    func GetQuote() -> String
    {
        if let Achievement = CheckAchievements()
        {
            UpdateButton(Image: Achievement.Image, State: .normal)
            
            ScorePerTap *= Achievement.Multiplier
            
            return "'\(Achievement.Name)': \(Achievement.Description)"
        }
        
        return Quotes[Helper.GetRandom(Min: 0, Max: Quotes.count)]
    }
    
    func CheckAchievements() -> Achievement?
    {
        if let Available = Achievements.first(where: { $0.Points <= Score && !$0.Obtained })
        {
            Available.Obtained = true
            
            return Available
        }
        
        return nil
    }
    
    func MoveButton()
    {
        let X = Helper.GetRandom(Min: 0, Max: Int(Bounds.width) - Int(Button.bounds.width))
        
        let Y = Helper.GetRandom(Min: 0, Max: Int(Bounds.height) - Int(Button.bounds.height))
        
        Button.isSelected = false
        Button.isUserInteractionEnabled = true
        
        Button.frame.origin = CGPoint(x: X, y: Y)
    }
}
