//
//  StopWatch.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/3/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class StopWatch {
    
    private static var startTime: Double = 0
    private static var currentTime: Double = 0
    
    static func updateTime(current: Double) {
        if startTime == 0 {
            startTime = current
            currentTime = current
        } else {
            currentTime = current
        }
    }
    
    static func elapsedTimeInSeconds() -> Int {
        return Int(currentTime - startTime)
    }
    
}
