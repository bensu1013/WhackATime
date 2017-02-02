//
//  GameScene.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let factory = DropletFactory()
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        self.addChild(factory.droplets)
        
        factory.createDroplet()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        factory.createDroplet()
        for touch in touches {
            let point = touch.location(in: self)
            
            for drop in factory.droplets.children {
                
                if drop.contains(point) {
                    
                    self.backgroundColor = UIColor.red
                    drop.removeFromParent()
                    
                }
                
            }
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("wonder")
        var a: SKPhysicsBody!
        var b: SKPhysicsBody!
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            a = contact.bodyA
            b = contact.bodyB
        } else {
            a = contact.bodyA
            b = contact.bodyB
        }
        
        if a.categoryBitMask == 2 && b.categoryBitMask == 4 {
            
            b.node?.removeFromParent()
            
        }
        
        
    }
    
    
}



class DropletFactory {
    
    var droplets = SKNode()
    
    func createDroplet() {
        
        let drop = Droplet(texture: nil, color: UIColor.blue, size: CGSize(width: 50, height: 50))
        let x = CGFloat(arc4random_uniform(UInt32(1000))) - 600
        drop.position = CGPoint(x: x, y: 300)
        droplets.addChild(drop)
        
    }
    
}





