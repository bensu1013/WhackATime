//
//  CloudFactory.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/9/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

class CloudFactory {
    
    static var clouds = SKNode()
    
    private static var cloudTextures = [
        SKTexture(imageNamed: "cloud1"),
        SKTexture(imageNamed: "cloud2"),
        SKTexture(imageNamed: "cloud3"),
        SKTexture(imageNamed: "cloud4"),
        SKTexture(imageNamed: "cloud5"),
        SKTexture(imageNamed: "cloud6"),
        SKTexture(imageNamed: "cloud7"),
        SKTexture(imageNamed: "cloud8"),
        SKTexture(imageNamed: "cloud9")]
    
    static func cycleClouds() -> SKAction {
        
        let delay = arc4random_uniform(UInt32(50)) / 10
        
        let timeDelay = SKAction.wait(forDuration: Double(delay))
        let rain = SKAction.run { createCloud() }
        return SKAction.sequence([timeDelay, rain])
        
    }
    
    private static func createCloud() {
        
        let index = Int(arc4random_uniform(UInt32(cloudTextures.count)))
        let texture = cloudTextures[index]
        
        let cloud = Cloud(texture: texture, color: UIColor.clear, size: texture.size())
        let x:CGFloat = 750
        let y = CGFloat(arc4random_uniform(UInt32(200))) + 150
        
        cloud.position = CGPoint(x: x, y: y)
        clouds.addChild(cloud)
        
    }
    
}
