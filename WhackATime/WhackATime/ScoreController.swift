//
//  ScoreController.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/3/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import CoreData

class ScoreController {
    
    static let main = ScoreController()
    
    private var scoreHistory: [Int] = []
    private var currentScore: Int = 0
    private var comboCounter: Int = 0
    
    private init() {
        print("scorecontroller init")
        scoreHistory = DataStore.sharedInstance.getScores()
    }
    
    func saveScores() {
        
        DataStore.sharedInstance.saveScores(values: scoreHistory)
        
    }
    
    func resetCounters() {
        currentScore = 0
        comboCounter = 0
    }
    
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
        resetCounters()
        saveScores()
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

class DataStore {
    
    static let sharedInstance = DataStore()
    
    private var scores = [Scores]()
    
    private init() {}
    
    func getScores() -> [Int] {
        
        var scoreArray = [Int]()
        
        if !scores.isEmpty {
            
            scoreArray.append(Int(scores[0].first!)!)
            scoreArray.append(Int(scores[0].second!)!)
            scoreArray.append(Int(scores[0].third!)!)
            scoreArray.append(Int(scores[0].fourth!)!)
            scoreArray.append(Int(scores[0].fifth!)!)
            scoreArray.append(Int(scores[0].sixth!)!)
            scoreArray.append(Int(scores[0].seventh!)!)
            scoreArray.append(Int(scores[0].eighth!)!)
            scoreArray.append(Int(scores[0].ninth!)!)
            scoreArray.append(Int(scores[0].tenth!)!)
            
        }
        
        return scoreArray
        
    }
    
    func saveScores(values: [Int]) {
        
        if !scores.isEmpty {
            scores[0].first = "\(values[0])"
            scores[0].second = "\(values[1])"
            scores[0].third = "\(values[2])"
            scores[0].fourth = "\(values[3])"
            scores[0].fifth = "\(values[4])"
            scores[0].sixth = "\(values[5])"
            scores[0].seventh = "\(values[6])"
            scores[0].eighth = "\(values[7])"
            scores[0].ninth = "\(values[8])"
            scores[0].tenth = "\(values[9])"
        }
        
        saveContext()
    }
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "ScoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func fetchData() {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Scores>(entityName: "Scores")
        
        do {
            scores = try context.fetch(fetchRequest)
        } catch {
            
        }
        
        if scores.isEmpty {
            generateNewData()
        }
        
    }
    
    func generateNewData() {
        
        let context = persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Scores", in: context)
        let task = NSManagedObject(entity: entity!, insertInto: context) as! Scores
        
        task.first = "0"
        task.second = "0"
        task.third = "0"
        task.fourth = "0"
        task.fifth = "0"
        task.sixth = "0"
        task.seventh = "0"
        task.eighth = "0"
        task.ninth = "0"
        task.tenth = "0"
        
        do {
            try context.save()
            scores.append(task)
        }catch{
            
        }
        
        self.saveContext()
        
    }
    
}


