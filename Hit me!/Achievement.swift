//
//  Achievement.swift
//  Hit me!
//
//  Created by Alexandro Luongo on 27/10/16.
//  Copyright © 2016 Angelo Rako. All rights reserved.
//

import Foundation

class Achievement
{
    var Name:String
    var Description:String
    
    var Points:Double
    var Obtained:Bool
    
    init(Name:String, Description:String, Points:Double, Obtained:Bool)
    {
        self.Name = Name
        self.Description = Description
        
        self.Points = Points
        self.Obtained = Obtained
    }
}
