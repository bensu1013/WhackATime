//
//  LandingViewBackground.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/18/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

class LandingScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        let bunny = self.childNode(withName: "bunny")
        
        let animate = SKAction.animate(with: [SKTexture(image: #imageLiteral(resourceName: "bunny1_ready")), SKTexture(image: #imageLiteral(resourceName: "bunny1_stand"))], timePerFrame: 0.5)
        
        let repetition = SKAction.repeatForever(animate)
        
        bunny?.run(repetition)
        
    }

}
