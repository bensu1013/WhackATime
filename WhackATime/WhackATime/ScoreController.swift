//
//  ScoreController.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/3/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class ScoreController {
    
    static let main = ScoreController()
    
    private var scoreHistory: [Int] = []
    private var currentScore: Int = 0
    private var comboCounter: Int = 0
    
    private init() {}
    
    func getScoreHistory() -> [Int] {
        return scoreHistory
    }
    
    func getHighScore() -> Int {
        return scoreHistory.isEmpty ? 0 : scoreHistory[0]
    }
    
    func addNewScore() {
        scoreHistory.append(currentScore)
        scoreHistory.sort { return $0 > $1 }
        if scoreHistory.count > 10 {
            scoreHistory.removeLast()
        }
    }
    
    func getCurrentScore() -> Int {
        return currentScore
    }
    
    func addToComboCounter() {
        comboCounter += 1
        calculateScore()
    }
    
    private func calculateScore() {
        switch comboCounter {
        case 1...19:
            currentScore += 1
        case 20:
            currentScore += 5
        case 21...49:
            currentScore += 2
        case 50:
            currentScore += 10
        case 51...99:
            currentScore += 3
        case 100:
            currentScore += 20
        case 200:
            currentScore += 50
        default:
            currentScore += 4
        }
    }
    
}
