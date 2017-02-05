//
//  LandingView.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/4/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

protocol LandingViewDelegate {
    func startGameTapped()
}

class LandingView: UIView {
    
    var delegate: LandingViewDelegate?
    var startGame = UIButton()
    var checkScores = UIButton()
    var credits = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.blue
        
        startGame.frame = CGRect(x: frame.width * 0.3, y: frame.height * 0.4, width: frame.width * 0.4, height: frame.height * 0.2)
        startGame.setTitle("Start", for: .normal)
        startGame.addTarget(self, action: #selector(startGameAction), for: .touchUpInside)
        self.addSubview(startGame)
        
        checkScores.frame = CGRect(x: frame.width * 0.3, y: frame.height * 0.62, width: frame.width * 0.4, height: frame.height * 0.2)
        checkScores.setTitle("Scores", for: .normal)
        checkScores.addTarget(self, action: #selector(checkScoresAction), for: .touchUpInside)
        self.addSubview(checkScores)
        
        credits.frame = CGRect(x: frame.width * 0.3, y: frame.height * 0.84, width: frame.width * 0.4, height: frame.height * 0.2)
        credits.setTitle("Credits", for: .normal)
        credits.addTarget(self, action: #selector(creditsAction), for: .touchUpInside)
        self.addSubview(credits)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("landing go bye bye")
    }
    
    @objc private func startGameAction() {
        delegate?.startGameTapped()
    }
    
    @objc private func checkScoresAction() {
        
    }
    
    @objc private func creditsAction() {
        
    }
    
}



