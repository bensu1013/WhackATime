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
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.categoryBitMask = 4
        self.physicsBody?.collisionBitMask = 3
        self.physicsBody?.contactTestBitMask = 3
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("byebye")
    }
    
    
}
