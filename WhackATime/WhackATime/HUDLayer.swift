//
//  HUDLayer.swift
//  WhackATime
//
//  Created by Benjamin Su on 2/3/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

class HudLayer: UIView {
    
    let scoreCounter = UILabel()
    let timer = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        scoreCounter.frame = CGRect(x: UIScreen.main.bounds.size.width * 0.64, y: 10, width: 100, height: 30)
        scoreCounter.backgroundColor = UIColor.clear
        scoreCounter.text = "Yo"
        scoreCounter.textColor = UIColor.black
        self.addSubview(scoreCounter)
        
        
        timer.frame = CGRect(x: UIScreen.main.bounds.size.width * 0.33, y: 10, width: 100, height: 30)
        timer.backgroundColor = UIColor.clear
        timer.text = "0:01"
        self.addSubview(timer)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
