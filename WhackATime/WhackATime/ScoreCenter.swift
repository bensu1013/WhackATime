//
//  ScoreCenter.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation


class ScoreCenter {
    
    static let main = ScoreCenter()
    
    private var currentScore = 0
    private var topScore = 0
    private var timer = 0
    
    func resetScore() {
        currentScore = 0
    }
    
    func updateScore(by value: Int) {
        currentScore += value
    }
    
    func setTopScore() {
        topScore = currentScore
    }
    
    func incrementTimer() {
        timer += 1
    }
    
    func resetTimer() {
        timer = 0
    }
    
}
