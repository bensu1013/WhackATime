//
//  MainViewController.swift
//  WhackATime
//
//  Created by Benjamin Su on 3/3/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    var containerView = UIView()
    var actingVC : UIViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DataStore.sharedInstance.fetchData()
        
        self.containerView.frame = self.view.bounds
        self.view.addSubview(containerView)
        
        addNotificationObservers()
        loadNewViewController(with: "landingvc")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(observerNotification), name: Notification.Name.landingVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(observerNotification), name: Notification.Name.gameVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(observerNotification), name: Notification.Name.scoreVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(observerNotification), name: Notification.Name.creditVC, object: nil)
    }
    
    
    func observerNotification(with notification: Notification) {
        
        self.switchToViewController(with: notification.name.rawValue)
        
//        switch notification.name {
//        case Notification.Name.landingVC:
//            self.switchToViewController(with: notification.name.rawValue)
//        case Notification.Name.gameVC:
//            self.switchToViewController(with: notification.name.rawValue)
//        default:
//            fatalError("Well shitters")
//        }
    }
    
    func switchToViewController(with id: String) {
        print("switching vc")
        let currentVC = actingVC
        currentVC?.willMove(toParentViewController: nil)
        
        loadNewViewController(with: id)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.actingVC.view.alpha = 1.0
            currentVC?.view.alpha = 0.0
        }) { success in
            currentVC?.view.removeFromSuperview()
            currentVC?.removeFromParentViewController()
            self.actingVC.didMove(toParentViewController: self)
        }
    }
    
    func loadNewViewController(with id: String) {
        self.actingVC = loadViewController(with: id)
        self.add(viewController: actingVC, animated: true)
    }
    
    
    
    func loadViewController(with id: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id)
    }
    
    func add(viewController: UIViewController, animated: Bool = false) {
        self.addChildViewController(viewController)
        containerView.addSubview(viewController.view)
        containerView.alpha = 0.0
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParentViewController: self)
        
        guard animated else { containerView.alpha = 1.0; return }
        
        UIView.transition(with: containerView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.containerView.alpha = 1.0
        }) { _ in }
    }
    

}


//Notification values
extension Notification.Name {
    
    //Meant for creation and changing of view controllers in game
    static let landingVC = Notification.Name(rawValue: "landingvc")
    static let gameVC = Notification.Name(rawValue: "gamevc")
    static let scoreVC = Notification.Name(rawValue: "scorevc")
    static let creditVC = Notification.Name(rawValue: "creditvc")
    
    //Gamescene communication with its VC
    static let menuOpen = Notification.Name(rawValue: "menuopen")
    static let gameEnd = Notification.Name(rawValue: "gameend")
    
    //objects notifying scene of changes
    static let startGame = Notification.Name(rawValue: "startgame")
    static let resumeGame = Notification.Name(rawValue: "resumegame")
    static let pauseGame = Notification.Name(rawValue: "pausegame")
    
}




