//
//  BreakoutBehaviour.swift
//  Breakout
//
//  Created by James Dorrian on 19/04/2017.
//  Copyright © 2017 JD_13369451. All rights reserved.
//

import UIKit

class BreakoutBehaviour: UIDynamicBehavior {
    
    lazy var collidor: UICollisionBehavior = {
        let behaviour = UICollisionBehavior()
        return behaviour
    }()
    
    lazy var gravity: UIGravityBehavior = {
        let behaviour = UIGravityBehavior()
        behaviour.magnitude = 0.2
        behaviour.gravityDirection = CGVector(dx: 0.0, dy: 1 * 0.5)
        //adjust this value using user specified information found in settings tab
        return behaviour
    }()
    
    lazy var ballSpecificBehaviour: UIDynamicItemBehavior = {
       let behaviour = UIDynamicItemBehavior()
        behaviour.elasticity = GlobalAttributes.sharedInstance.bounce
        behaviour.resistance = 0
        behaviour.friction = 0
        behaviour.allowsRotation = true
       return behaviour
    }()
    
    override init(){
        super.init()
        addChildBehavior(collidor)
        addChildBehavior(gravity)
        addChildBehavior(ballSpecificBehaviour)
    }
    
    func startGame(_ ball: Ball){
        ballSpecificBehaviour.elasticity=GlobalAttributes.sharedInstance.bounce
        let pushBehaviour = UIPushBehavior(items: [ball], mode: UIPushBehaviorMode.instantaneous)
        let rand:Double = (drand48() * 40) + 70.0
        pushBehaviour.angle = CGFloat((rand) * M_PI/180) //btw 70 and 110 degrees
        pushBehaviour.magnitude = 0.2
        pushBehaviour.action = { [unowned pushBehaviour] in
            pushBehaviour.removeItem(ball)
            pushBehaviour.dynamicAnimator?.removeBehavior(pushBehaviour)
        }
        pushBehaviour.action = { [unowned pushBehaviour] in
            pushBehaviour.removeItem(ball)
            pushBehaviour.dynamicAnimator?.removeBehavior(pushBehaviour)
        }
        addChildBehavior(pushBehaviour)
    }
    
    func applyBallForce(_ ball: Ball){
        let pushBehaviour = UIPushBehavior(items: [ball], mode: UIPushBehaviorMode.instantaneous)
        pushBehaviour.magnitude = 0.2
        ballSpecificBehaviour.elasticity=GlobalAttributes.sharedInstance.bounce
        let linearVelocity = ballSpecificBehaviour.linearVelocity(for: ball)
        let direction = Double(atan2(linearVelocity.y, linearVelocity.x))
        var inverse = CGFloat((direction + M_PI).truncatingRemainder(dividingBy: (2 * M_PI)))
        let rand:Double = (Double(arc4random_uniform(1)))
        var rands:CGFloat = 0
        if (rand == 1){
            rands = 0.1
        } else {
            rands = -0.1
        }
        inverse = inverse + rands
        pushBehaviour.angle = CGFloat((inverse))
        pushBehaviour.action = { [unowned pushBehaviour] in
            pushBehaviour.removeItem(ball)
            pushBehaviour.dynamicAnimator?.removeBehavior(pushBehaviour)
        }
        addChildBehavior(pushBehaviour)
    }
    
    func addBoundary(_ path: UIBezierPath, named name: String){
        collidor.removeBoundary(withIdentifier: name as NSCopying)
        collidor.addBoundary(withIdentifier: name as NSCopying, for: path)
    }
    
    func removeBoundary(named name: String) {
        collidor.removeBoundary(withIdentifier: name as NSCopying)
    }
    
    func addBall(_ ball: Ball){
        dynamicAnimator?.referenceView?.addSubview(ball)
        gravity.addItem(ball)
        collidor.addItem(ball)
        ballSpecificBehaviour.addItem(ball)
    }
    
    func removeBall(_ ball: Ball){
        gravity.removeItem(ball)
        ballSpecificBehaviour.removeItem(ball)
        collidor.removeItem(ball)
        ball.removeFromSuperview()
    }
    
    func movePaddle(_ view: UIView){
        removeBoundary(named: "paddle")
        addBoundary(UIBezierPath(rect:view.frame) ,named: "paddle")
    }
    
}
