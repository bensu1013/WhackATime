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

    var cat: Cat?
    var rainFallLevel: Int = 0
    let hud = HudLayer.main
    
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        self.addChild(DropletFactory.droplets)
        
        cat = self.childNode(withName: "cat") as? Cat
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            let point = touch.location(in: self)
            
            for drop in DropletFactory.droplets.children {
                
                if drop.contains(point) {
                    
                    let droplet = drop as! Droplet
                    droplet.tappedByUser()
                    
                    ScoreController.main.addToComboCounter()
                    hud.showNew(score: ScoreController.main.getCurrentScore())
                    
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        cat?.update()
        
        StopWatch.updateTime(current: currentTime)
        
        hud.setTimer(to: StopWatch.elapsedTimeInSeconds())
        
        createRainFall()
    }
    
    private func createRainFall() {
        if StopWatch.elapsedTimeInSeconds() == 0 && rainFallLevel == 0 {
            self.run(DropletFactory.createRainFall(with: 1), withKey: "rainFall1")
            rainFallLevel += 1
        } else if StopWatch.elapsedTimeInSeconds() > 5 && rainFallLevel == 1 {
            self.run(DropletFactory.createRainFall(with: 1.91), withKey: "rainFall2")
            rainFallLevel += 1
        } else if StopWatch.elapsedTimeInSeconds() > 10 && rainFallLevel == 2 {
            self.run(DropletFactory.createRainFall(with: 2.73), withKey: "rainFall3")
            rainFallLevel += 1
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var a: SKPhysicsBody!
        var b: SKPhysicsBody!
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            a = contact.bodyA
            b = contact.bodyB
        } else {
            a = contact.bodyA
            b = contact.bodyB
        }
        //droplet touches floor
        if a.categoryBitMask == 2 && b.categoryBitMask == 4 {
            
            let droplet = b.node as! Droplet
            droplet.splashOnFloor()
           
        //droplet touches cat
        } else if a.categoryBitMask == 1 && b.categoryBitMask == 4 {
            
            let droplet = b.node as! Droplet
            droplet.splashOnCat()
            
            let cat = a.node as! Cat
            cat.touchedDroplet()
            
        }
        
    }
    
}



class DropletFactory {
    
    static var droplets = SKNode()
    
    static func createDroplet() {
        
        let drop = Droplet(texture: nil, color: UIColor.blue, size: CGSize(width: 64, height: 64))
        let x = CGFloat(arc4random_uniform(UInt32(1334))) - 667
        drop.position = CGPoint(x: x, y: 300)
        droplets.addChild(drop)
        
    }
    
    static func createRainFall(with delay: Double) -> SKAction {
        
        return SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: delay), SKAction.run{ DropletFactory.createDroplet() }]))
        
    }
    
}





