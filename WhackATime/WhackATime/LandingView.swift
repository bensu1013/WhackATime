//
//  LandingView.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/4/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

protocol LandingViewDelegate: class {
    func startGameTapped()
}

class LandingView: UIView {
    
    weak var delegate: LandingViewDelegate?
    var startGame = UIButton()
    var checkScores = UIButton()
    var credits = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.blue
        loadSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("landing go bye bye")
    }
    
    @objc fileprivate func startGameAction() {
        delegate?.startGameTapped()
    }
    
    @objc fileprivate func checkScoresAction() {

        print("checking scores")
        let scoreView = ScoreView(frame: self.frame)
        self.addSubview(scoreView)
    }
    
    @objc fileprivate func creditsAction() {
        let creditView = CreditView(frame: self.frame)
        self.addSubview(creditView)
    }
    
}

//MARK: - Subviews
extension LandingView {
    
    fileprivate func loadSubviews() {
        
        loadStartGameButton()
        loadCheckScoresButton()
        loadCreditsButton()
        
    }
    
    fileprivate func loadStartGameButton() {
        startGame.frame = CGRect(x: frame.width * 0.3, y: frame.height * 0.4, width: frame.width * 0.4, height: frame.height * 0.12)
        startGame.backgroundColor = UIColor.green
        startGame.setTitle("Start", for: .normal)
        startGame.addTarget(self, action: #selector(startGameAction), for: .touchUpInside)
        self.addSubview(startGame)
    }
    
    fileprivate func loadCheckScoresButton() {
        checkScores.frame = CGRect(x: frame.width * 0.3, y: frame.height * 0.53, width: frame.width * 0.4, height: frame.height * 0.12)
        checkScores.backgroundColor = UIColor.yellow
        checkScores.setTitle("Scores", for: .normal)
        checkScores.addTarget(self, action: #selector(checkScoresAction), for: .touchUpInside)
        self.addSubview(checkScores)
    }
    
    fileprivate func loadCreditsButton() {
        credits.frame = CGRect(x: frame.width * 0.3, y: frame.height * 0.66, width: frame.width * 0.4, height: frame.height * 0.12)
        credits.backgroundColor = UIColor.brown
        credits.setTitle("Credits", for: .normal)
        credits.addTarget(self, action: #selector(creditsAction), for: .touchUpInside)
        self.addSubview(credits)
    }
    
}



















