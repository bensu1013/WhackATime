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
    
    case left, right, still, lick
    
}

class Cat: SKSpriteNode {
    
    var direction: DirectionMovement = .still
    
    func update() {
        
        switch direction {
        case .left:
            if let _ = self.action(forKey: "moveLeft") {
                
            } else {
                direction = .still
            }
        case .right:
            if let _ = self.action(forKey: "moveRight") {
                
            } else {
                direction = .still
            }
        case .still:
            movementController()
        case .lick:
            if let _ = self.action(forKey: "lickSelf") {
                
            } else {
                direction = .still
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
        
        self.color = UIColor.green
        
        let action = SKAction.sequence([SKAction.wait(forDuration: 2), SKAction.run {
            self.color = UIColor.red
            }])
        
        self.run(action, withKey: "lickSelf")
        direction = .lick
    }
    
}






