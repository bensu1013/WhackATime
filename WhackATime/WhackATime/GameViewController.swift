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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameScene()
        
        DataStore.sharedInstance.fetchData()
       
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    fileprivate func loadGameScene() {
        let gameView = SKView(frame: self.view.frame)
        
        gameView.backgroundColor = UIColor.white
        
        // Load the SKScene from 'GameScene.sks'
        if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
            
            
            
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFit
            
            // Present the scene
            gameView.presentScene(scene)
            
            scene.gsDelegate = self
            
        }
        
        gameView.ignoresSiblingOrder = true
        gameView.showsFPS = true
        gameView.showsNodeCount = true
        
        let hud = HudLayer.main
        hud.vcDelegate = self
        gameView.addSubview(hud)
        
        self.view = gameView
        
    }
    
}

//Alerts
extension GameViewController {
    
    fileprivate func gameOverAlert(scene: GameScene) {
        
        let alert = UIAlertController(title: "Oh Boy", message: "Bunny was crushed by falling heads.", preferredStyle: .alert)
        let replay = UIAlertAction(title: "Replay", style: .default) { (action) in
            scene.startGame()
        }
        let quit = UIAlertAction(title: "Menu", style: .cancel) { (action) in
            
            NotificationCenter.default.post(name: Notification.Name.landingVC, object: nil)
        }
        
        alert.addAction(replay)
        alert.addAction(quit)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    fileprivate func menuAlertView() {
        
        let alert = UIAlertController(title: "Paused", message: nil, preferredStyle: .alert)
        let replay = UIAlertAction(title: "Resume", style: .default) { (action) in
            HudLayer.main.gsDelegate?.resumeGameFromMenu()
        }
        
        let quit = UIAlertAction(title: "Quit", style: .cancel) { (action) in
            NotificationCenter.default.post(name: Notification.Name.landingVC, object: nil)
        }
        
        alert.addAction(replay)
        alert.addAction(quit)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

extension GameViewController: HUDToVCDelegate {
    func showMenu() {
        menuAlertView()
    }
}

extension GameViewController: GameSceneDelegate {
    func gameOver(scene: GameScene) {
        gameOverAlert(scene: scene)
    }
}
