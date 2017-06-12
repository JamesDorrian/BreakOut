//
//  GlobalAttributes.swift
//  Breakout
//
//  Created by James Dorrian on 23/04/2017.
//  Copyright © 2017 JD_13369451. All rights reserved.
//

import Foundation
import UIKit
class GlobalAttributes {
    static let sharedInstance = GlobalAttributes()
    fileprivate let userDefaults = UserDefaults.standard
    
    var bounce:CGFloat { //bounce
        get{
            if ((userDefaults.value(forKey: "bounce") as? CGFloat) != nil) {
                return (userDefaults.value(forKey: "bounce") as? CGFloat)!
            } else {
                return 0.8
            }
        }
        set {
            userDefaults.setValue(newValue, forKey: "bounce")
        }
    }
    
    var ballColor:String {
        get {
            if ((userDefaults.value(forKey: "ballColor") as? String) != nil) {
                return (userDefaults.value(forKey: "ballColor") as? String)!
            } else {
                return "red"
            }
        }
        set {
            userDefaults.setValue(newValue, forKey: "ballColor")
        }
    }
    
    var numberOfRows:Double {
        get {
            if ((userDefaults.value(forKey: "numberOfRows") as? Double) != nil) {
                return (userDefaults.value(forKey: "numberOfRows") as? Double)!
            } else {
                return 1
            }
        }
        set {
            userDefaults.setValue(newValue, forKey: "numberOfRows")
        }
    }
    
    var highScore:Int {
        get {
            if (userDefaults.value(forKey: "highScore") as? Int != nil){
                return (userDefaults.value(forKey: "highScore") as? Int)!
            } else {
                return 0
            }
        }
        set {
            userDefaults.setValue(newValue, forKey:"highScore")
        }
    }
}
