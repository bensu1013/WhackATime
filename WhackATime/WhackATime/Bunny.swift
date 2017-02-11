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
    
    case left, right, sit, still
    
}

class Bunny: SKSpriteNode {
    
    var direction: DirectionMovement = .still
    
    private var hurtTexture = SKTexture(imageNamed: "bunny1_hurt")
    private var jumpTexture = SKTexture(imageNamed: "bunny1_jump")
    private var readyTexture = SKTexture(imageNamed: "bunny1_ready")
    private var standTexture = SKTexture(imageNamed: "bunny1_stand")
    private var walkTexture = [SKTexture(imageNamed: "bunny1_walk1"),
                               SKTexture(imageNamed: "bunny1_walk2"),
                               SKTexture(imageNamed: "bunny1_walk1"),
                               SKTexture(imageNamed: "bunny1_walk2")]
    
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
        case .sit:
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
                sitDown()
            default:
                stayStill()
                
            }
            
        }
        
    }
    
    private func stayStill() {
        
        self.texture = standTexture
        
        self.run(SKAction.wait(forDuration: 1), withKey: "stayStill")
        
        direction = .still
    }
    
    private func moveLeft() {
        
        let distance = CGFloat(arc4random_uniform(100)) + 100
        
        let dura = Double(distance / 100)
        
        if xScale > 0 {
            self.xScale = self.xScale * -1
        }
        
        self.run(SKAction.animate(with: walkTexture, timePerFrame: 0.15))
        
        self.run(SKAction.moveTo(x: -distance, duration: dura), withKey: "moveLeft")
        
        direction = .left
        
    }
    
    private func moveRight() {
        
        let distance = CGFloat(arc4random_uniform(100)) + 100
        
        let dura = Double(distance / 100)
        
        if xScale < 0 {
            self.xScale = self.xScale * -1
        }
        
        let animate = SKAction.animate(with: walkTexture, timePerFrame: 0.15)
        
        let movement = SKAction.moveTo(x: distance, duration: dura)
        
        let sequence = SKAction.sequence([animate, movement])
        
        self.run(sequence, withKey: "moveRight")
        
        direction = .right
    }
    
    private func sitDown() {
        
        self.texture = jumpTexture
        
        let action = SKAction.sequence([SKAction.wait(forDuration: 2), SKAction.run {
            self.texture = self.readyTexture
            }])
        
        self.run(action, withKey: "sitDown")
        
        direction = .sit
        
    }
    
    func touchedDroplet() {
        
        self.texture = hurtTexture
        
    }
    
}






