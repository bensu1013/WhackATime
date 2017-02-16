//
//  HUDLayer.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/3/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

protocol HUDToVCDelegate: class {
    func showMenu(alert: UIAlertController)
}

protocol HUDToGSDelegate: class {
    func pauseGameForMenu()
    func resumeGameFromMenu()
}

class HudLayer: UIView {
    
    static var main = HudLayer(frame: UIScreen.main.bounds)
    
    weak var vcDelegate: HUDToVCDelegate?
    weak var gsDelegate: HUDToGSDelegate?
    
    let scoreLabel = UILabel()
    let timerLabel = UILabel()
    let menuButton = UIButton()
    
    private var elapsedTime: Double = 0
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        scoreLabel.frame = CGRect(x: UIScreen.main.bounds.size.width * 0.64, y: 10, width: 100, height: 30)
        scoreLabel.backgroundColor = UIColor.clear
        scoreLabel.text = "Score: 0"
        scoreLabel.textColor = UIColor.black
        self.addSubview(scoreLabel)
        
        
        timerLabel.frame = CGRect(x: UIScreen.main.bounds.size.width * 0.33, y: 10, width: 100, height: 30)
        timerLabel.backgroundColor = UIColor.clear
        timerLabel.text = "Time: 0:00"
        self.addSubview(timerLabel)
        
        menuButton.frame = CGRect(x: UIScreen.main.bounds.size.width * 0.9, y: 10, width: 100, height: 44)
        menuButton.setTitle("Menu", for: .normal)
        menuButton.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        self.addSubview(menuButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func menuButtonAction() {
        gsDelegate?.pauseGameForMenu()
        vcDelegate?.showMenu(alert: menuAlertView())
    }
    
    func setTimer(to seconds: Int) {
        
        var timeString = ""
        
        let minutes = seconds / 60
        let seconds = seconds - (minutes * 60)
        
        timeString = "\(minutes):"
        timeString += seconds < 10 ? "0\(seconds)" : "\(seconds)"
        
        timerLabel.text = timeString
        
    }
    
    func showNew(score: Int) {
        
        scoreLabel.text = "Score: \(score)"
        
    }
    
    fileprivate func menuAlertView() -> UIAlertController{
        
        let alert = UIAlertController(title: "Oh Boy", message: "Bunny was crushed by falling heads.", preferredStyle: .alert)
        let replay = UIAlertAction(title: "Replay", style: .default) { (action) in
            
        }
        
        let quit = UIAlertAction(title: "Outta Here", style: .cancel) { (action) in
            self.gsDelegate?.resumeGameFromMenu()
        }
        
        alert.addAction(replay)
        alert.addAction(quit)
        
        return alert
        
    }
    
}







