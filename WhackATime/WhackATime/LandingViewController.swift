//
//  LandingViewController.swift
//  WhackATime
//
//  Created by Benjamin Su on 3/3/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let landingView = LandingView(frame: self.view.frame)
        self.view = landingView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
