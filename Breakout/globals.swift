//
//  globals.swift
//  Breakout
//
//  Created by James Dorrian on 22/04/2017.
//  Copyright © 2017 JD_13369451. All rights reserved.
//

import UIKit
import Foundation
class globals{
    static let shared = UserSettingVC()
    fileprivate init() {}
    fileprivate let userDefaults = UserDefaults.standard

    var elasticity: CGFloat {
        get {
            if let elasticity = userDefaults.value(forKey: "bounce") as? CGFloat {
                return elasticity
            } else {
                return 0.5
            }
        }
        set {
            userDefaults.setValue(newValue, forKey: "bounce")
            userDefaults.synchronize()
        }
    }

    
    
}
