//
//  ScoreView.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/6/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

class ScoreView: UIView {
    
    let scoreOutliner = UIView()
    let scoreLabel = UILabel()
    let textField = UITextView()
    let doneButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.green
        
        loadScoreOutliner()
        loadScoreLabel()
        loadTextField()
        loadDoneButton()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
    }
    
    @objc func doneButtonAction() {
        NotificationCenter.default.post(name: Notification.Name.landingVC, object: nil)
    }
    
}

extension ScoreView {
    
    fileprivate func loadScoreOutliner() {
        
        scoreOutliner.frame = CGRect(x: frame.width * 0.4, y: frame.height * 0.04, width: frame.width * 0.2, height: frame.height * 0.08)
        scoreOutliner.backgroundColor = UIColor.blue
        scoreOutliner.alpha = 0.5
        scoreOutliner.layer.borderWidth = 3
        scoreOutliner.layer.borderColor = UIColor.black.cgColor
        scoreOutliner.transform = CGAffineTransform.init(rotationAngle: -0.0523599)
        self.addSubview(scoreOutliner)
        
        UIView.animate(withDuration: 2.0, delay: 0.0, options: [.allowUserInteraction, .repeat, .autoreverse], animations: {
            self.scoreOutliner.transform = CGAffineTransform.init(rotationAngle: 0.10472)
        }, completion: nil)
        UIView.animate(withDuration: 5.0, delay: 0.0, options: [.allowUserInteraction, .repeat, .autoreverse], animations: {
            self.scoreOutliner.backgroundColor = UIColor.brown
        }, completion: nil)
        
    }
    
    fileprivate func loadScoreLabel() {
        scoreLabel.frame = CGRect(x: frame.width * 0.4, y: frame.height * 0.04, width: frame.width * 0.2, height: frame.height * 0.08)
        scoreLabel.backgroundColor = UIColor.clear
        scoreLabel.textAlignment = .center
        scoreLabel.font = Fonts.score
        scoreLabel.text = "Scores:"
        self.addSubview(scoreLabel)
    }
    
    fileprivate func loadTextField() {
        textField.frame = CGRect(x: frame.width * 0.3, y: frame.height * 0.12, width: frame.width * 0.4, height: frame.height * 0.65)
        textField.backgroundColor = UIColor.clear
        textField.textAlignment = .center
        textField.font = Fonts.score
        textField.isUserInteractionEnabled = false
        self.addSubview(textField)
        
        let scores = ScoreController.main.getScoreHistory()
        var scoreText = ""
        
        for count in 0...9 {
            if count < scores.count {
                scoreText += "\(count + 1)) \(scores[count])\n"
            } else {
                scoreText += "\(count + 1)) None\n"
            }
        }
        textField.text = scoreText
    }
    
    fileprivate func loadDoneButton() {
        doneButton.frame = CGRect(x: frame.width * 0.35, y: frame.height * 0.8, width: frame.width * 0.3, height: frame.height * 0.1)
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        doneButton.backgroundColor = UIColor.green
        doneButton.setTitle("Done", for: .normal)
        self.addSubview(doneButton)
    }
}
