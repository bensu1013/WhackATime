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
    
    private var elapsedTime: Double = 0
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        scoreLabel.frame = CGRect(x: UIScreen.main.bounds.size.width * 0.64, y: 10, width: 100, height: 30)
        scoreLabel.backgroundColor = UIColor.clear
        scoreLabel.text = "Yo"
        scoreLabel.textColor = UIColor.black
        self.addSubview(scoreLabel)
        
        
        timerLabel.frame = CGRect(x: UIScreen.main.bounds.size.width * 0.33, y: 10, width: 100, height: 30)
        timerLabel.backgroundColor = UIColor.clear
        timerLabel.text = "0:00"
        self.addSubview(timerLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTimer(to seconds: Int) {
        
        timerLabel.text = "\(seconds)"
        
    }
    
    func showNew(score: Int) {
        
        scoreLabel.text = "\(score)"
        
    }
    
    
    
}







