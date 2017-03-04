//
//  Droplet.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit


class Droplet: SKSpriteNode {
    
    var hasContacted: Bool = false
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
       
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.categoryBitMask = 4
        self.physicsBody?.collisionBitMask = 3
        self.physicsBody?.contactTestBitMask = 3
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func splashOnFloor() {
        
        hasContacted = true
        
        self.color = UIColor.brown
        
        let delay = SKAction.wait(forDuration: 0.25)
        let delete = SKAction.run { self.removeFromParent() }
        
        self.run( SKAction.sequence([delay, delete]))
    }
    
    func tappedByUser() {
        
        hasContacted = true
        
        let initialContact = SKAction.run {
            self.physicsBody?.affectedByGravity = false
            self.physicsBody?.velocity.dy = 0
            self.alpha = 0.5
        }
        
        let delayTime = SKAction.wait(forDuration: 0.5)
        
        let remove = SKAction.run {
            self.removeFromParent()
        }
        
        let sequence = SKAction.sequence([initialContact, delayTime, remove])
        
        self.run(sequence)
        
    }
    
    func splashOnBunny() {
        
        hasContacted = true
        self.color = UIColor.red
        
        self.run( SKAction.sequence([SKAction.wait(forDuration: 0.25), SKAction.run {
            self.removeFromParent()
            }]))
        
    }
    
}
