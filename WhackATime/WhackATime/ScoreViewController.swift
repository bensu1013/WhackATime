//
//  ScoreViewController.swift
//  WhackATime
//
//  Created by Benjamin Su on 3/3/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let scoreView = ScoreView(frame: self.view.frame)
        self.view = scoreView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
