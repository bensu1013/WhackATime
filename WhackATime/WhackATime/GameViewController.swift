//
//  GameViewController.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var gameView: SKView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let landingView = LandingView(frame: view.frame)
        landingView.delegate = self
        self.view = landingView
        
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    fileprivate func loadGameScene() {
        gameView = SKView(frame: self.view.frame)
        
        // Load the SKScene from 'GameScene.sks'
        if let scene = SKScene(fileNamed: "GameScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            gameView?.presentScene(scene)
        }
        
        gameView?.ignoresSiblingOrder = true
        gameView?.showsFPS = true
        gameView?.showsNodeCount = true
        
        self.view = gameView
        
        let hud = HudLayer.main
        self.view.addSubview(hud)
        
    }
    
}



extension GameViewController: LandingViewDelegate {
    
    func startGameTapped() {
        loadGameScene()
    }
    
}
