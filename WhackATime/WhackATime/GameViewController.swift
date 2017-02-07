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
        if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
            
            scene.gsDelegate = self
            
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
        StopWatch.isPaused = false
    }
    
}

//Alerts
extension GameViewController {
    
    fileprivate func gameOverAlert(scene: GameScene) {
        
        let alert = UIAlertController(title: "Nooo", message: "The cat got wet, he will now haunt us in our dreams.", preferredStyle: .alert)
        let replay = UIAlertAction(title: "Replay", style: .default) { (action) in
            scene.speed = 1
            StopWatch.isPaused = false
        }
        let quit = UIAlertAction(title: "Outta Here", style: .cancel) { (action) in
            let landingView = LandingView(frame: self.view.frame)
            landingView.delegate = self
            self.view = landingView
        }
        
        alert.addAction(replay)
        alert.addAction(quit)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    fileprivate func checkScoresAlert() {
        
        var scores = ""
        
        for score in ScoreController.main.getScoreHistory() {
            scores += "\n\(score)"
        }
        
        if scores == "" { scores = "None \n \n Go Play!" }
        
        let alert = UIAlertController(title: "Scores", message: scores, preferredStyle: .alert)
        let replay = UIAlertAction(title: "Done", style: .cancel, handler: nil)
        
        alert.addAction(replay)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}

extension GameViewController: LandingViewDelegate {
    
    func startGameTapped() {
        loadGameScene()
    }
    
    //Deprecated, remove when confirmed
    func checkScoresTapped() {
        checkScoresAlert()
    }
    
    func creditsTapped() {
        
    }
    
}

extension GameViewController: GameSceneDelegate {
    func gameOver(scene: GameScene) {
        gameOverAlert(scene: scene)
    }
}
