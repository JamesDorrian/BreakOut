//
//  Paddle.swift
//  Breakout
//
//  Created by James Dorrian on 19/04/2017.
//  Copyright © 2017 JD_13369451. All rights reserved.
//

import UIKit

class Paddle: UIView {
    let paddleWidth:CGFloat = 100
    let velocityController: CGFloat = 40
    let paddleHeight:CGFloat = 10
    let distFromFloor:CGFloat = 100
    var referenceView: UIView!
    var pos: CGPoint!
//    paddleBoundary = UIBezierPath(ovalIn: paddleView.frame)
    init(referenceView: UIView){
        super.init(frame: CGRect.zero)
        self.referenceView = referenceView
        backgroundColor = UIColor(red:100/255.0 , green:100/255.0 ,blue:100/255.0 ,alpha: 1.0)
        frame = CGRect(origin: CGPoint.zero, size:CGSize(width:paddleWidth, height:paddleHeight))
        layer.cornerRadius = CGFloat(paddleHeight / 2.5)
        frame.origin.x = referenceView.bounds.size.width/2 - paddleWidth/2
        frame.origin.y = referenceView.bounds.size.height - distFromFloor
        pos = CGPoint(x: frame.origin.x, y: frame.origin.y)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move(velocity: CGPoint){
        let velocity = velocity
        let proposedCenter = CGPoint(x: center.x + velocity.x/velocityController, y: self.center.y)
        let newCenter = setNewCenter(proposedCenter)
        
        UIView.animate(withDuration: 0.0, delay: 0.0,
            options: [UIViewAnimationOptions.allowUserInteraction, UIViewAnimationOptions.curveEaseIn],
            animations: {
            self.center = newCenter
        },
            completion: nil
        )
    }
    
    func setNewCenter(_ proposedCenter: CGPoint) -> CGPoint {
        var currCenter = proposedCenter //proposed center is actual center
        //paddle co-ords
        let centerLeftPaddle = floor(currCenter.x - (paddleWidth/2))
        let centerRightPaddle = ceil(currCenter.x + (paddleWidth/2))
        //screen co-ords
        let screenLeftEdge = floor(referenceView.bounds.origin.x) //0
        let screenRightEdge = ceil(referenceView.bounds.width)
        
        //left edge check
        if centerLeftPaddle <= screenLeftEdge {
            currCenter.x = floor(CGFloat(paddleWidth/2))
        }
        //right edge check
        else if centerRightPaddle >= screenRightEdge {
            currCenter.x = ceil(referenceView.bounds.width - (paddleWidth/2))
        }
        return currCenter //return the modified center to await animation
    }
    
}
