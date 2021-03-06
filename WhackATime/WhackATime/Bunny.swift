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
                               SKTexture(imageNamed: "bunny1_walk2")]
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.categoryBitMask = 1
        self.physicsBody?.collisionBitMask = 6
        self.physicsBody?.contactTestBitMask = 4
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    func reset(pos: CGFloat) {
        
        self.position.x = pos
        self.texture = readyTexture
        self.removeAllActions()
    }
    
    deinit {
        
    }
    
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
            
            let rand = arc4random_uniform(3)
            
            switch rand {
            case 0:
                stayStill()
            case 1:
                moveLeft()
            case 2:
                moveRight()
//            case 3:
//                sitDown()
            default:
                stayStill()
                
            }
            
        }
        
    }
    
    private func stayStill() {
        
        self.run(SKAction.repeatForever(SKAction.animate(with: [readyTexture, standTexture], timePerFrame: 0.25)), withKey: "standing")
        
        let wait = SKAction.wait(forDuration: 2)
        
        let done = SKAction.run { self.removeAction(forKey: "standing") }
        
        let sequence = SKAction.sequence([wait, done])
        
        self.run(sequence, withKey: "stayStill")
        
        direction = .still
        
    }
    
    private func moveLeft() {
        
        if self.position.x < -575 {
            moveRight()
        } else {
            
            var distance = CGFloat(arc4random_uniform(100)) + 100
            
            var dura = Double(distance / 100)
            
            if self.position.x - distance < 575 {
                distance = 576 + self.position.x
                dura = Double(distance / 100)
            }
            
            self.xScale = -1
            
            self.run(SKAction.repeatForever(SKAction.animate(with: walkTexture, timePerFrame: 0.15)), withKey: "moving")
            
            let move = SKAction.moveBy(x: -distance, y: 0, duration: dura)
            
            let done = SKAction.run { self.removeAction(forKey: "moving") }
            
            let sequence = SKAction.sequence([move, done])
            
            self.run(sequence, withKey: "moveLeft")
            
            direction = .left
        }
    }
    
    private func moveRight() {
        
        if self.position.x > 575 {
            moveLeft()
        } else {
            
            var distance = CGFloat(arc4random_uniform(100)) + 100
            
            var dura = Double(distance / 100)
            
            if self.position.x + distance > 575 {
                distance = 576 - self.position.x
                dura = Double(distance / 100)
            }
            
            self.xScale = 1
            
            self.run(SKAction.repeatForever(SKAction.animate(with: walkTexture, timePerFrame: 0.15)), withKey: "moving")
            
            let move = SKAction.moveBy(x: distance, y: 0, duration: dura)
            
            let done = SKAction.run { self.removeAction(forKey: "moving") }
            
            let sequence = SKAction.sequence([move, done])
            
            self.run(sequence, withKey: "moveRight")
            
            direction = .right
        }
        
        
        
    }
    
    private func sitDown() {
        
        self.texture = jumpTexture
        
        self.run(SKAction.wait(forDuration: 2), withKey: "sitDown")
        
        direction = .sit
        
    }
    
    func touchedDroplet() {
        
        self.texture = hurtTexture

    }
    
}






