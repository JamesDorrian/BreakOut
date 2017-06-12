//
//  Brick.swift
//  Breakout
//
//  Created by James Dorrian on 19/04/2017.
//  Copyright © 2017 JD_13369451. All rights reserved.
//

import UIKit

class Brick: UIView {
    let hitpoints: Int = 1
    var collisionCount:Int = 0
    
    override init(frame: CGRect) {
        //collisionCount = 0
        super.init(frame: frame)
        backgroundColor = UIColor.RandomColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIColor {
    static func  RandomColor() -> UIColor {
        let randomHue = CGFloat(arc4random()) / CGFloat(RAND_MAX)
        return UIColor(hue: randomHue, saturation: 1.0, brightness: 1.0, alpha: 0.5)
    }
}
