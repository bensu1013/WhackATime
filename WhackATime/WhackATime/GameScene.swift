//
//  GameScene.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

protocol GameSceneDelegate: class {
    func gameOver(scene: GameScene)
}

class GameScene: SKScene {

    weak var gsDelegate: GameSceneDelegate?
    var bunny: Bunny?
    var rainFallLevel: Int = 0
    let hud = HudLayer.main
    
    override func didMove(to view: SKView) {
        
        hud.gsDelegate = self
        self.physicsWorld.contactDelegate = self
        self.addChild(RainFactory.droplets)
        self.addChild(CloudFactory.clouds)
        bunny = self.childNode(withName: "bunny") as? Bunny
        
        startGame()
        
    }
    
    deinit {
        print("bye bye game scene")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let point = touch.location(in: self)
            for drop in RainFactory.droplets.children {
                if drop.contains(point) {
                    
                    if let droplet = drop as? Droplet {
                        if !droplet.hasContacted {
                            
                            RainFactory.createSplash(at: droplet.position)
                            droplet.tappedByUser()
                            ScoreController.main.addToComboCounter()
                            hud.showNew(score: ScoreController.main.getCurrentScore())
                            
                        }
                    }
                }
            }
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        bunny?.update()
        StopWatch.updateTime(current: currentTime)
        hud.setTimer(to: StopWatch.elapsedTimeInSeconds())
        createRainFall()
        
    }
    
    func startGame() {
        
        speed = 1
        StopWatch.isPaused = false
        self.run(CloudFactory.cycleClouds(delay: 5))
        bunny?.position.x = 0
        
    }
    
    fileprivate func resetScene() {
        
        StopWatch.reset()
        speed = 0
        self.removeAllActions()
        rainFallLevel = 0
        RainFactory.droplets.removeAllChildren()
        CloudFactory.clouds.removeAllChildren()
        ScoreController.main.addNewScore()
        hud.setTimer(to: 0)
        hud.showNew(score: 0)
        
    }
    
    fileprivate func createRainFall() {
        if StopWatch.elapsedTimeInSeconds() == 0 && rainFallLevel == 0 {
            self.run(RainFactory.createRainFall(with: 1), withKey: "rainFall1")
            rainFallLevel += 1
        } else if StopWatch.elapsedTimeInSeconds() > 15 && rainFallLevel == 1 {
            self.run(RainFactory.createRainFall(with: 1.91), withKey: "rainFall2")
            rainFallLevel += 1
        } else if StopWatch.elapsedTimeInSeconds() > 30 && rainFallLevel == 2 {
            self.run(RainFactory.createRainFall(with: 2.73), withKey: "rainFall3")
            rainFallLevel += 1
        } else if StopWatch.elapsedTimeInSeconds() > 45 && rainFallLevel == 3 {
            self.run(RainFactory.createRainFall(with: 3.12), withKey: "rainFall3")
            rainFallLevel += 1
        } else if StopWatch.elapsedTimeInSeconds() > 60 && rainFallLevel == 4 {
            self.run(RainFactory.createRainFall(with: 3.97), withKey: "rainFall3")
            rainFallLevel += 1
        } else if StopWatch.elapsedTimeInSeconds() > 120 && rainFallLevel == 5 {
            self.run(RainFactory.createRainFall(with: 4.32), withKey: "rainFall3")
            rainFallLevel += 1
        }
    }
    
    
}

extension GameScene: HUDToGSDelegate {
    
    func pauseGameForMenu() {
        
        StopWatch.isPaused = true
        self.isPaused = true

    }
    
    func resumeGameFromMenu() {
        
        StopWatch.isPaused = false
        self.isPaused = false

    }
    
}

extension GameScene: SKPhysicsContactDelegate {
    
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
            
            if let droplet = b.node as? Droplet {
                if !droplet.hasContacted {
                    RainFactory.createSplash(at: droplet.position)
                    droplet.splashOnFloor()
                }
            }
            
            //splash touches floor
        } else if a.categoryBitMask == 2 && b.categoryBitMask == 8 {
            
            if let splash = b.node as? Splash {
                splash.removeFromParent()
            }
            
            //droplet touches cat
            
        } else if a.categoryBitMask == 1 && b.categoryBitMask == 4 {
            
            if let droplet = b.node as? Droplet {
                if !droplet.hasContacted {
                    RainFactory.createSplash(at: droplet.position)
                    droplet.splashOnCat()
                }
            }
            if let bunny = a.node as? Bunny {
                bunny.touchedDroplet()
            }
            
            //round should end at this point
            gsDelegate?.gameOver(scene: self)
            resetScene()
            
            //splash touches cat
        } else if a.categoryBitMask == 1 && b.categoryBitMask == 8 {
            
            if let splash = b.node as? Splash {
                splash.removeFromParent()
            }
            
        }
        
    }

}













