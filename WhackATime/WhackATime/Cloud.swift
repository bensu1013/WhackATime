//
//  Cloud.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/9/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

class Cloud: SKSpriteNode {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        self.zPosition = -50
        
        soarThroughTheSky()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func soarThroughTheSky() {
        
        let moveDuration = Double(arc4random_uniform(5)) + 15
        
        let move = SKAction.moveBy(x: -1500, y: 0, duration: moveDuration)
        
        let remove = SKAction.run { self.removeFromParent() }
        
        let sequence = SKAction.sequence([move,remove])
        
        self.run(sequence)
        
    }
    
}
