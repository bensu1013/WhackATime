//
//  GameView.swift
//  WhackATime
//
//  Created by Benjamin Su on 3/3/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit
import SpriteKit

class GameView: SKView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func loadGameScene() {
        
        self.backgroundColor = UIColor.white
        
        // Load the SKScene from 'GameScene.sks'
        if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
            
            
            
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFit
            
            // Present the scene
            self.presentScene(scene)
            
        }
        
        self.ignoresSiblingOrder = true
        self.showsFPS = true
        self.showsNodeCount = true
        
        self.addSubview(HudLayer.main)
        
    }
    
    
    
}
