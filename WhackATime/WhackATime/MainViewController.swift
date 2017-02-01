//
//  ViewController.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let dropletFactory = DropletFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropletFactory.droplets = UIView(frame: view.frame)
        
        view.addSubview(dropletFactory.droplets)

      
            dropletFactory.createDroplet()
        
        
        
    }

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touching")
        dropletFactory.createDroplet()
        print(dropletFactory.droplets.frame)
        for touch in touches {
            let point = touch.location(in: self.view)
            
            for drop in dropletFactory.droplets.subviews {
                
                if drop.frame.contains(point) {
                    view.backgroundColor = UIColor.red
                    drop.removeFromSuperview()
                }
                
            }
        }
    }

}

class DropletFactory {
    
    var droplets: UIView!
    
    
    func createDroplet() {
        
        let drop = Droplet(frame: CGRect(origin: DropletRandomizer.getRandomPosition(), size: CGSize(width: 50, height: 50)))
        
        droplets.addSubview(drop)
        
    }
}


class DropletRandomizer {
    
    static func getRandomPosition() -> CGPoint {
        
        let x = arc4random_uniform(UInt32(UIScreen.main.bounds.width))
        
        
        return CGPoint(x: CGFloat(x), y: 0)
    }
    
    
}







