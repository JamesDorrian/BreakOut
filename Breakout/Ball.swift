//
//  Ball.swift
//  Breakout
//
//  Created by James Dorrian on 19/04/2017.
//  Copyright © 2017 JD_13369451. All rights reserved.
//

import UIKit

class Ball: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        switch GlobalAttributes.sharedInstance.ballColor{
        case "red":
            backgroundColor = UIColor.red
            break
        case "green":
            backgroundColor = UIColor.green
            break
        case "blue":
            backgroundColor = UIColor.blue
            break
        case "black":
            backgroundColor = UIColor.black
            break
        case "white":
            backgroundColor = UIColor.white
            break
        case "orange":
            backgroundColor = UIColor.orange
            break
        default:
            backgroundColor = UIColor.red
            break
        }
        layer.cornerRadius = frame.size.width / 2.0
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .ellipse
    }

}
