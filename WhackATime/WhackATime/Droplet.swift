//
//  Droplets.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit

class Droplet: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blue
        
        UIView.animate(withDuration: 2, delay: 0, options: .allowUserInteraction, animations: { 
            self.frame.origin.y += 200
        }, completion: nil)
        
       
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    deinit {
        print("bye bye")
    }

}
