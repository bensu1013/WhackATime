//
//  Extensions.swift
//  WhackATime
//
//  Created by Benjamin Su on 3/4/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static var confetti: UIColor {
        
        let rand = Int(arc4random_uniform(4))
        
        var color: UIColor!
        
        switch rand {
        case 0:
            color = UIColor.yellow
        case 1:
            color = UIColor.red
        case 2:
            color = UIColor.green
        case 3:
            color = UIColor.blue
        default:
            color = UIColor.blue
        }
        
        return color
    }
    
}
