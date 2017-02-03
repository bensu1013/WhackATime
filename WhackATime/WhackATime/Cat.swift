//
//  Cat.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/2/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

enum DirectionMovement {
    
    case left, right, lick, still
    
}

class Cat: SKSpriteNode {
    
    var direction: DirectionMovement = .still
    
    func update() {
        
        switch direction {
        case .left:
            if !self.hasActions() {
                direction = .still
            }
        case .right:
            if !self.hasActions() {
                direction = .still
            }
        case .lick:
            if !self.hasActions() {
                direction = .still
            }
        case .still:
            if !self.hasActions() {
                movementController()
            }
        }
    }
    
    private func movementController() {
        
        if let _ = self.action(forKey: "stayStill") {
            
        } else {
            
            let rand = arc4random_uniform(4)
            
            switch rand {
            case 0:
                stayStill()
            case 1:
                moveLeft()
            case 2:
                moveRight()
            case 3:
                lickSelf()
            default:
                stayStill()
                
            }
            
        }
        
    }
    
    private func stayStill() {
        
        self.run(SKAction.wait(forDuration: 1), withKey: "stayStill")
        direction = .still
    }
    
    private func moveLeft() {
        
        let distance = CGFloat(arc4random_uniform(100)) + 100
        
        let dura = Double(distance / 100)
        
        self.run(SKAction.moveTo(x: -distance, duration: dura), withKey: "moveLeft")
        direction = .left
        
    }
    
    private func moveRight() {
        
        let distance = CGFloat(arc4random_uniform(100)) + 100
        
        let dura = Double(distance / 100)
        
        self.run(SKAction.moveTo(x: distance, duration: dura), withKey: "moveRight")
        direction = .right
    }
    
    private func lickSelf() {
        
        let action = SKAction.sequence([SKAction.run {
            self.color = UIColor.brown
            }, SKAction.wait(forDuration: 2), SKAction.run { self.color = UIColor.green }])
        
        self.run(action, withKey: "lickSelf")
        direction = .lick
    }
    
    func touchedDroplet() {
        
        self.color = UIColor.red
        
    }
    
}






