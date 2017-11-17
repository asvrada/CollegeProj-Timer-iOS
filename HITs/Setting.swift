//
//  Setting.swift
//  HITs
//
//  Created by WuZiJie on 2017/11/15.
//  Copyright © 2017年 TBD. All rights reserved.
//

import Foundation
import UIKit

class Setting {
    // In seconds
    var durationActive = 10
    // In seconds
    var durationRest = 5
    // 1 is the minimal value
    // If this hits 0, the workout is over
    var numberRep = 2

    var colorActive = "Red"
    var colorRest = "Green"
    var colorIdle = "White"
    var colorPaused = "Cyan"

    static var DICT_COLOR = [
        "Blue": UIColor.blue,
        "Brown": UIColor.brown,
        "Cyan": UIColor.cyan,
        "Dark Gray": UIColor.darkGray,
        "Gray": UIColor.gray,
        "Green": UIColor.green,
        "Light Gray": UIColor.lightGray,
        "Magenta": UIColor.magenta,
        "Orange": UIColor.orange,
        "Red": UIColor.red,
        "White": UIColor.white,
        "Yellow": UIColor.yellow]

    static var ARRAY_COLOR = Array(Setting.DICT_COLOR.keys)

    init() {

    }
    
    // Copy constructor
    init(_ other:Setting) {
        self.durationActive = other.durationActive
        self.durationRest = other.durationRest
        self.numberRep = other.numberRep
        self.colorRest = other.colorRest
        self.colorActive = other.colorActive
        self.colorPaused = other.colorPaused
    }

    // Some useful functions
    
    // Convert time in second to the format (minute and second)
    static func second2MinuteAndSecond (second: Int) -> (Int, Int) {
        return (second / 60, second % 60)
    }
    
    // Generate a list of string that represents Int from range min to max (Included)
    static func generateStringList(min:Int, max: Int) -> [String] {
        return (min...max).map { "\($0)" }
    }
    
}
