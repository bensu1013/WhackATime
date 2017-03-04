//
//  RainFactory.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/5/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

class RainFactory {
    
    static var droplets = SKNode()
    
    private static var dropTextures = [
        SKTexture(imageNamed: "elephant"),
        SKTexture(imageNamed: "giraffe"),
        SKTexture(imageNamed: "hippo"),
        SKTexture(imageNamed: "monkey"),
        SKTexture(imageNamed: "panda"),
        SKTexture(imageNamed: "parrot"),
        SKTexture(imageNamed: "penguin"),
        SKTexture(imageNamed: "pig"),
        SKTexture(imageNamed: "snake")
    ]
    
    static func createRainFall(with delay: Double) -> SKAction {
        
        let timeDelay = SKAction.wait(forDuration: delay)
        let rain = SKAction.run { createDroplet() }
        return SKAction.repeatForever(SKAction.sequence([timeDelay, rain]))
        
    }
    
    private static func createDroplet() {
        
        let index = Int(arc4random_uniform(UInt32(dropTextures.count)))
        let texture = dropTextures[index]
        
        let drop = Droplet(texture: texture, color: UIColor.clear, size: CGSize(width: texture.size().width / 4 , height: texture.size().height / 4))
        let x = CGFloat(arc4random_uniform(UInt32(1320))) - 660
        drop.position = CGPoint(x: x, y: 400)
        droplets.addChild(drop)
        
    }
    
    static func createSplash(at point: CGPoint) {
        
        let randomSplash = arc4random_uniform(4) + 2
        
        for _ in 0...Int(randomSplash) {
            
            let splash = Splash(texture: nil, color: UIColor.confetti, size: CGSize(width: 16, height: 16))
            splash.position = point
            droplets.addChild(splash)
            splash.physicsBody?.applyImpulse(CGVector(dx: drand48() - 0.5, dy: drand48() + 0.5))
            
        }
            
    }

}
