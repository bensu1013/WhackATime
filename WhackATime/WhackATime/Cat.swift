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
    
    case left, right, still
    
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
            
            if let _ = self.action(forKey: "stayStill") {
                
            } else {
                
                let rand = arc4random_uniform(3)
                
                if rand == 0 {
                    stayStill()
                } else if rand == 1 {
                    moveLeft()
                } else if rand == 2 {
                    moveRight()
                }
                
            }
        }
        
        
    }
    
    private func stayStill() {
        self.run(SKAction.wait(forDuration: 2), withKey: "stayStill")
    }
    
    private func moveLeft() {
        
        self.run(SKAction.moveTo(x: -200, duration: 2), withKey: "moveLeft")
        
    }
    
    private func moveRight() {
        
        self.run(SKAction.moveTo(x: 200, duration: 2), withKey: "moveRight")
        
    }
    
}
