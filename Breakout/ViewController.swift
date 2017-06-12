//
//  ViewController.swift
//  Breakout
//
//  Created by James Dorrian on 19/04/2017.
//  Copyright © 2017 JD_13369451. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate {

    //animatior
    lazy var animator: UIDynamicAnimator = {
        let dynamicAnim = UIDynamicAnimator(referenceView: self.ovewView)
        dynamicAnim.delegate = self
        return dynamicAnim
    }()
    
//    @IBOutlet weak var EndGameLabel: UILabel!
    @IBOutlet weak var EndGame: UILabel!
    
    @IBOutlet var ovewView: UIView!
    var paddle: Paddle?
    var balls = [Ball]()
    var gameStarted:Bool = false
    let breakoutBehaviour = BreakoutBehaviour()
    var gameClick:Int = 0
    var blocks = [String:Brick]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(breakoutBehaviour)
        breakoutBehaviour.collidor.collisionDelegate = self
        breakoutBehaviour.collidor.action = { [unowned self] in
            var counter = 0
            for ball in self.balls{
                if (ball.frame.intersects(self.ovewView.frame) == false) {
                    self.breakoutBehaviour.removeBall(ball)
                    self.balls.remove(at: counter)
                }
                counter += 1
            }
            //check if no balls -> fail end
            //destroy paddle
            //remove ball
            print("Number of remaining balls:" + String(self.balls.count))
            if(self.EndGame?.isHidden)!{
                if (self.balls.count <= 0){
                    self.paddle?.removeFromSuperview()
                    self.removeAll()
                    self.EndGame?.isHidden = false
                    self.EndGame?.text = "LOSER! CLICK TO PLAY AGAIN!"
                    self.gameClick = 0
                    return
                }
                
                //check if no bricks -> successful game end
                //destroy paddle
                //remove ball
                print("Number of remaining blocks:" + String(self.blocks.count))
                if(self.blocks.count <= 0){
                    self.paddle?.removeFromSuperview()
                    self.removeAll()
                    if(self.checkHighScore()){
                        let set = SettingsVC()
                        set.setScore()
                        self.EndGame?.text = "NEW HIGHSCORE:" + String(GlobalAttributes.sharedInstance.numberOfRows*5)
                        
                    } else {
                        self.EndGame?.text = "WINNER! SCORE:" + String(GlobalAttributes.sharedInstance.numberOfRows*5)
                        self.EndGame?.isHidden = false
                        self.gameClick = 0
                    }
                }
            }
        }
    }

    func checkHighScore() -> Bool{
        if(GlobalAttributes.sharedInstance.highScore < Int(GlobalAttributes.sharedInstance.numberOfRows*5)){
            return true
        }
        return false
    }
    
    func removeAll(){
        if (balls.count > 0){
            breakoutBehaviour.removeBall(balls[0])
            balls.removeAll()
        }
        for (identifier, brick) in blocks {
            breakoutBehaviour.removeBoundary(named: identifier)
            blocks.removeValue(forKey: identifier)
            brick.removeFromSuperview()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func paddleMover(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .ended: fallthrough
        case .changed:
            let velocity = sender.velocity(in: paddle)
            if let paddle = paddle {
                paddle.move(velocity: velocity)
                breakoutBehaviour.movePaddle(paddle)
            }
            sender.setTranslation(CGPoint.zero, in: ovewView)
        default: break
        }
    }
    
    @IBAction func startGame(_ sender: UITapGestureRecognizer) {
        gameClick = gameClick + 1
        if(gameClick == 1){
            self.EndGame?.isHidden = true
            createPaddle()
            createBall()
            createBlocks()
        }
        if(gameClick == 2){
            gameStarted = true
        }
        if (gameStarted == true && gameClick < 3){
            addScreenBounds()
            breakoutBehaviour.startGame(balls[0])
            gameStarted = true
        }
        if (gameStarted == true && gameClick > 2){
            breakoutBehaviour.applyBallForce(balls[0])
        }
    }
    
    func createPaddle(){
        paddle = Paddle(referenceView: ovewView)
        var paddleBoundary:UIBezierPath!
        if let paddleView = paddle {
            paddleBoundary = UIBezierPath(ovalIn: paddleView.frame)
        }
        breakoutBehaviour.addBoundary(paddleBoundary, named: "paddle")
        ovewView.addSubview(paddle!)
    }

    func createBall(){
        var frame = CGRect()
        frame.size = CGSize.init(width:15, height:15)
        frame.origin.x = paddle!.pos.x+(paddle!.paddleWidth/2)-(15/2)
        frame.origin.y = paddle!.pos.y-(15)
        let ball = Ball(frame: frame)
        balls.append(ball)
        breakoutBehaviour.addBall(ball)
        ovewView.addSubview(ball)
    }

    func addScreenBounds(){
        //set leftWall bounds
        let leftWall = UIBezierPath()
        leftWall.move(to: CGPoint(x: ovewView.bounds.origin.x, y: ovewView.bounds.size.height))
        leftWall.addLine(to: CGPoint(x:ovewView.bounds.origin.x, y: ovewView.bounds.origin.y))
        //set ceiling bounds
        let ceiling = UIBezierPath()
        ceiling.move(to: CGPoint(x: ovewView.bounds.origin.x, y: ovewView.bounds.origin.y))
        ceiling.addLine(to: CGPoint(x: ovewView.bounds.size.width, y: ovewView.bounds.origin.y))
        //set rightWall bounds
        let rightWall = UIBezierPath()
        rightWall.move(to: CGPoint(x: ovewView.bounds.size.width, y: ovewView.bounds.origin.y))
        rightWall.addLine(to: CGPoint(x: ovewView.bounds.size.width, y: ovewView.bounds.size.height))
        
        breakoutBehaviour.addBoundary(leftWall, named: "left")
        breakoutBehaviour.addBoundary(ceiling, named: "top")
        breakoutBehaviour.addBoundary(rightWall, named: "right")
    }
    
    func createBlocks(){
        let screenWidth = ovewView.bounds.size.width
        let numCols = 5
        let singleSpace = 3
        let totalSpace = CGFloat(numCols * singleSpace)
        let blockWidth = (screenWidth - totalSpace)/5
        let blockHeight = 30
        let numRows = Int(GlobalAttributes.sharedInstance.numberOfRows)
        for row in 0 ..< numRows {
            for col in 0 ..< numCols {
                var frame = CGRect(origin: CGPoint.zero , size: CGSize(width: blockWidth, height: CGFloat(blockHeight)))
                frame.origin = CGPoint(x:(col * Int(blockWidth)+((col+1)*singleSpace)) , y: (row * blockHeight) + blockHeight)
                var block: Brick!
                block = Brick(frame: frame)
                ovewView.addSubview(block)
                let blockPath = UIBezierPath(rect: block.frame)
                let blockName = "block" + "\(row).\(col)"
                breakoutBehaviour.addBoundary(blockPath, named: blockName)
                blocks[blockName] = block
            }
        }
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint){
        if let blockName = identifier as? String{
            if let block = blocks[blockName]{
                block.collisionCount = block.collisionCount + 1;
                if (block.collisionCount >= block.hitpoints){
                    //remove boundary
                    //remove from array
                    self.blocks.removeValue(forKey: blockName)
                    breakoutBehaviour.removeBoundary(named: blockName)
                    //change color to red then disappear
                    UIView.animate(withDuration: 0.2, animations:{block.backgroundColor = UIColor.RandomColor()},
                                   completion: {didComplete in
                                    block.backgroundColor = UIColor.RandomColor()
                                    UIView.animate(withDuration: 0.2, animations:
                                        {block.backgroundColor = UIColor.RandomColor()}, completion: {didComplete in
                                        block.backgroundColor = UIColor.RandomColor()
                                        UIView.animate(withDuration: 0.2, animations:
                                            {block.backgroundColor = UIColor.RandomColor()
                                                block.removeFromSuperview()})})})
                }
                //if not destroyed, the collision count is incremented but nothing is removed but still animate the block
                //possibly make opaque for a nicer animation
                else {
                    UIView.animate(withDuration: 0.2, animations:{block.backgroundColor = UIColor.RandomColor()},
                                  completion: {didComplete in
                                    block.backgroundColor = UIColor.RandomColor()
                                    UIView.animate(withDuration: 0.2, animations:
                                        {block.backgroundColor = UIColor.RandomColor()}, completion: {didComplete in
                                            block.backgroundColor = UIColor.RandomColor()
                                            UIView.animate(withDuration: 0.2, animations:
                                                {block.backgroundColor = UIColor.RandomColor()})})})
                }
                    
            }
        }
    }
}


