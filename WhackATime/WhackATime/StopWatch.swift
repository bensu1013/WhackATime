//
//  StopWatch.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/3/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class StopWatch {
    
    static var isPaused = false
    private static var startTime: Double = 0
    private static var currentTime: Double = 0
    
    static func updateTime(current: Double) {
        if !isPaused {
            if startTime == 0 {
                startTime = current
                currentTime = current
            } else {
                currentTime = current
            }
        } else {
            if startTime == 0 {
                startTime = current
                currentTime = current
            } else {
                let timePaused = current - currentTime
                startTime += timePaused
                currentTime += timePaused
            }
        }
    }
    
    static func elapsedTimeInSeconds() -> Int {
        return Int(currentTime - startTime)
    }
    
    static func reset() {
        isPaused = true
        startTime = 0
        currentTime = 0
    }
}
