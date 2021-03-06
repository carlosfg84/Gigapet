//
//  MonsterImg.swift
//  Gigapet
//
//  Created by Carlos Flores Guardado on 9/28/16.
//  Copyright © 2016 Carlos Flores Guardado. All rights reserved.
//

import Foundation
import UIKit

class MonsterImg: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playIdleAnimation()
    }
    
    func playIdleAnimation() -> Bool {
        
        self.image = UIImage(named: "idle1.png")
        
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        for var x = 1; x <= 4; x += 1 {
            let img = UIImage(named: "idle\(x).png")
            imgArray.append(img!)
        }
    
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
        
        return true
    }
    
    func playDeathAnimation() -> Bool {
        
        self.image = UIImage(named: "dead5.png")
        
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        for var x = 1; x <= 5; x += 1 {
            let img = UIImage(named: "dead\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
        
        return true
    }
}
