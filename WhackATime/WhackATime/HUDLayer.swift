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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        scoreCounter.frame = CGRect(x: UIScreen.main.bounds.size.width / 2 - 50, y: 0, width: 100, height: 30)
        scoreCounter.backgroundColor = UIColor.clear
        scoreCounter.text = "Yo"
        scoreCounter.textColor = UIColor.black
        self.addSubview(scoreCounter)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
