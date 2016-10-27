//
//  Helper.swift
//  Hit me!
//
//  Created by Alexandro Luongo on 27/10/16.
//  Copyright © 2016 Angelo Rako. All rights reserved.
//

import Foundation

class Helper
{
    static func GetRandom(Min:Int, Max:Int) -> Int
    {
        let Difference = Max - Min
        
        return Min + Int(arc4random_uniform(UInt32(Difference)))
    }
}
