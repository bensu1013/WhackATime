//
//  Splash.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/4/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

class Splash: SKSpriteNode {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.categoryBitMask = 8
        self.physicsBody?.collisionBitMask = 3
        self.physicsBody?.contactTestBitMask = 1
        
        self.run( SKAction.sequence([SKAction.wait(forDuration: 2.5), SKAction.run {
            self.removeFromParent()
            }]))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
