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
    var bunnies = [Bunny]()
    var rainFallLevel: Int = 0
    let hud = HudLayer.main
    
    override func didMove(to view: SKView) {

        self.physicsWorld.contactDelegate = self
        self.addChild(RainFactory.droplets)
        self.addChild(CloudFactory.clouds)
        
        for count in 0...1 {
            let bunny = Bunny(texture: nil, color: UIColor.clear, size: CGSize(width: 120, height: 190))
            if count == 0 {
                bunny.position = CGPoint(x: -200, y: -239)
            } else {
                bunny.position = CGPoint(x: 200, y: -239)
            }
            
            
            bunnies.append(bunny)
            self.addChild(bunny)
        }

        resetScene()
        startGame()
        
        NotificationCenter.default.addObserver(self, selector: #selector(startGame), name: Notification.Name.startGame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resumeGame), name: Notification.Name.resumeGame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pauseGame), name: Notification.Name.pauseGame, object: nil)
        
    }
    
    deinit {
        
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
        for bunny in bunnies {
            bunny.update()
            
        }
        StopWatch.updateTime(current: currentTime)
        hud.setTimer(to: StopWatch.elapsedTimeInSeconds())
        createRainFall()
        createClouds()
        
    }
    
    @objc fileprivate func startGame() {
        self.isPaused = false
        StopWatch.isPaused = false
        for (count, bunny) in bunnies.enumerated() {
            if count == 0 {
                bunny.reset(pos: -200)
            } else {
                bunny.reset(pos: 200)
            }
            
        }
    }
    
    @objc fileprivate func resumeGame() {
        self.isPaused = false
        StopWatch.isPaused = false
    }
    
    @objc fileprivate func pauseGame() {
        self.isPaused = true
        StopWatch.isPaused = true
    }
    
    func resetScene() {
        
        StopWatch.reset()
        self.isPaused = true
        self.removeAllActions()
        rainFallLevel = 0
        RainFactory.droplets.removeAllChildren()
        CloudFactory.clouds.removeAllChildren()
        ScoreController.main.addNewScore()
        hud.setTimer(to: 0)
        hud.showNew(score: 0)
        
    }
    
    fileprivate func createClouds() {
        
        if let _ = self.action(forKey: "createCloud") {
            
        } else {
            self.run(CloudFactory.cycleClouds(), withKey: "createCloud")
        }
        
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
            
        //droplet touches bunny
        } else if a.categoryBitMask == 1 && b.categoryBitMask == 4 {
            
            if let droplet = b.node as? Droplet {
                if !droplet.hasContacted {
                    RainFactory.createSplash(at: droplet.position)
                    droplet.splashOnBunny()
                }
            }
            
            if let bunny = a.node as? Bunny {
                bunny.touchedDroplet()
            }
            
            //round should end at this point
            self.resetScene()
            NotificationCenter.default.post(name: Notification.Name.gameEnd, object: nil)
            
            
        //splash touches bunny
        } else if a.categoryBitMask == 1 && b.categoryBitMask == 8 {
            
            if let splash = b.node as? Splash {
                splash.removeFromParent()
            }
            
        }
        
    }

}













