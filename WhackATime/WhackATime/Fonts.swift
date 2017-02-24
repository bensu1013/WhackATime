//
//  Fonts.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/21/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

struct Fonts {
    
    static var landing: UIFont {
        
        let size = UIScreen.main.bounds.height / 12
        
        let font = UIFont(name: "Futura-CondensedExtraBold", size: size)
        
        return font!
        
    }
    
    static var score: UIFont {
        
        let size = UIScreen.main.bounds.height / 24
        
        let font = UIFont(name: "Futura-CondensedExtraBold", size: size)
        
        return font!
        
    }
    
    static var credit: UIFont {
        
        let size = UIScreen.main.bounds.height / 16
        
        let font = UIFont(name: "Futura-CondensedExtraBold", size: size)
        
        return font!
        
    }
    
    static var hudlayer: UIFont {
        
        let size = UIScreen.main.bounds.height / 28
        
        let font = UIFont(name: "Futura-CondensedExtraBold", size: size)
        
        return font!
        
    }
    
}
