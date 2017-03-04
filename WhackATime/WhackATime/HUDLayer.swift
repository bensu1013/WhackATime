//
//  HUDLayer.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/3/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

class HudLayer: UIView {
    
    static var main = HudLayer(frame: UIScreen.main.bounds)
    
    let scoreLabel = UILabel()
    let timerLabel = UILabel()
    let menuButton = UIButton()
    
    private var elapsedTime: Double = 0
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        subviewSetup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func menuButtonAction() {
        NotificationCenter.default.post(name: Notification.Name.menuOpen, object: nil)
        NotificationCenter.default.post(name: Notification.Name.pauseGame, object: nil)
    }
    
    func setLabelColors(ipad: Bool) {
        
        if ipad {
            scoreLabel.textColor = UIColor.white
            timerLabel.textColor = UIColor.white
            menuButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            scoreLabel.textColor = UIColor.black
            timerLabel.textColor = UIColor.black
            menuButton.setTitleColor(UIColor.black, for: .normal)
        }
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
    
}

extension HudLayer {
    
    fileprivate func subviewSetup() {
        self.backgroundColor = UIColor.clear
        
        scoreLabel.frame = CGRect(x: UIScreen.main.bounds.size.width * 0.6, y: UIScreen.main.bounds.size.height * 0.06, width: UIScreen.main.bounds.size.width * 0.1, height: UIScreen.main.bounds.size.height * 0.1)
        scoreLabel.backgroundColor = UIColor.clear
        scoreLabel.font = Fonts.hudlayer
        scoreLabel.text = "Score: 0"
        self.addSubview(scoreLabel)
        
        timerLabel.frame = CGRect(x: UIScreen.main.bounds.size.width * 0.3, y: UIScreen.main.bounds.size.height * 0.06, width: UIScreen.main.bounds.size.width * 0.1, height: UIScreen.main.bounds.size.height * 0.1)
        timerLabel.backgroundColor = UIColor.clear
        timerLabel.font = Fonts.hudlayer
        timerLabel.text = "Time: 0:00"
        self.addSubview(timerLabel)
        
        menuButton.frame = CGRect(x: UIScreen.main.bounds.size.width * 0.8, y: UIScreen.main.bounds.size.height * 0.06, width: UIScreen.main.bounds.size.width * 0.1, height: UIScreen.main.bounds.size.height * 0.1)
        menuButton.setTitle("Menu", for: .normal)
        menuButton.titleLabel?.font = Fonts.hudlayer
        menuButton.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        self.addSubview(menuButton)
    }
    
}





