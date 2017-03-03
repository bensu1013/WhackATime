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
    
    let textField = UITextView()
    let doneButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.green
        
        loadTextField()
        loadDoneButton()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("bye bye scoreview")
    }
    
    @objc func doneButtonAction() {
        NotificationCenter.default.post(name: Notification.Name.landingVC, object: nil)
    }
    
}

extension ScoreView {
    
    func loadTextField() {
        textField.frame = CGRect(x: frame.width * 0.3, y: frame.height * 0.1, width: frame.width * 0.4, height: frame.height * 0.65)
        textField.backgroundColor = UIColor.clear
        textField.textAlignment = .center
        textField.font = Fonts.score
        textField.isUserInteractionEnabled = false
        self.addSubview(textField)
        
        let scores = ScoreController.main.getScoreHistory()
        var scoreText = "Scores\n"
        
        for count in 0...9 {
            if count < scores.count {
                scoreText += "\(count + 1)) \(scores[count])\n"
            } else {
                scoreText += "\(count + 1)) None\n"
            }
        }
        textField.text = scoreText
    }
    
    func loadDoneButton() {
        doneButton.frame = CGRect(x: frame.width * 0.35, y: frame.height * 0.8, width: frame.width * 0.3, height: frame.height * 0.1)
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        doneButton.backgroundColor = UIColor.green
        doneButton.setTitle("Done", for: .normal)
        self.addSubview(doneButton)
    }
}
