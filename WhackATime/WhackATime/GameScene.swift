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
        self.addChild(RainFactory.droplets)
        
        cat = self.childNode(withName: "cat") as? Cat
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            let point = touch.location(in: self)
            for drop in RainFactory.droplets.children {
                if drop.contains(point) {
                    let droplet = drop as! Droplet
                    if !droplet.hasContacted {
                        
                        droplet.tappedByUser()
                        ScoreController.main.addToComboCounter()
                        hud.showNew(score: ScoreController.main.getCurrentScore())
                        
                    }
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
            self.run(RainFactory.createRainFall(with: 1), withKey: "rainFall1")
            rainFallLevel += 1
        } else if StopWatch.elapsedTimeInSeconds() > 15 && rainFallLevel == 1 {
            self.run(RainFactory.createRainFall(with: 1.91), withKey: "rainFall2")
            rainFallLevel += 1
        } else if StopWatch.elapsedTimeInSeconds() > 30 && rainFallLevel == 2 {
            self.run(RainFactory.createRainFall(with: 2.73), withKey: "rainFall3")
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
            if !droplet.hasContacted {
                RainFactory.createSplash(at: droplet.position)
                droplet.splashOnFloor()
            }
            
            
        //droplet touches cat
        } else if a.categoryBitMask == 1 && b.categoryBitMask == 4 {
            
            let droplet = b.node as! Droplet
            if !droplet.hasContacted {
                droplet.splashOnCat()
            }
           
            let cat = a.node as! Cat
            cat.touchedDroplet()
            
        } else if a.categoryBitMask == 1 && b.categoryBitMask == 8 {
            
            let splash = b.node as! Splash
            splash.removeFromParent()
            
        }
        
    }
    
}



class RainFactory {
    
    static var droplets = SKNode()
    
    static func createRainFall(with delay: Double) -> SKAction {
        
        let timeDelay = SKAction.wait(forDuration: delay)
        let rain = SKAction.run { RainFactory.createDroplet() }
        return SKAction.repeatForever(SKAction.sequence([timeDelay, rain]))
        
    }
    
    static func createDroplet() {
        
        let drop = Droplet(texture: nil, color: UIColor.blue, size: CGSize(width: 64, height: 64))
        let x = CGFloat(arc4random_uniform(UInt32(1320))) - 660
        drop.position = CGPoint(x: x, y: 400)
        droplets.addChild(drop)
        
    }
    
    static func createSplash(at point: CGPoint) {
        
        let splash1 = Splash(texture: nil, color: UIColor.blue, size: CGSize(width: 16, height: 16))
        let splash2 = Splash(texture: nil, color: UIColor.blue, size: CGSize(width: 16, height: 16))
        let splash3 = Splash(texture: nil, color: UIColor.blue, size: CGSize(width: 16, height: 16))
        let splash4 = Splash(texture: nil, color: UIColor.blue, size: CGSize(width: 16, height: 16))
        
        splash1.position = point
        splash2.position = point
        splash3.position = point
        splash4.position = point
        
        droplets.addChild(splash1)
        droplets.addChild(splash2)
        droplets.addChild(splash3)
        droplets.addChild(splash4)
        
        splash1.physicsBody?.applyImpulse(CGVector(dx: -3, dy: 2))
        splash2.physicsBody?.applyImpulse(CGVector(dx: -1, dy: 4))
        splash3.physicsBody?.applyImpulse(CGVector(dx: 1, dy: 4))
        splash4.physicsBody?.applyImpulse(CGVector(dx: 3, dy: 2))
        
    }
    
    
    
}














