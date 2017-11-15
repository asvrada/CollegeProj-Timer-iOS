//
//  MainViewController.swift
//  HITs
//
//  Created by WuZiJie on 2017/11/15.
//  Copyright © 2017年 TBD. All rights reserved.
//

import UIKit
import AudioToolbox

class MainViewController: UIViewController {
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var labelReps: UILabel!
    @IBOutlet weak var button: UIButton!

    // Global
    var SETTING = Setting()
    // Used as local copy of conf file
    // Only update when start button is pressed
    var tmpSetting = Setting()

    // Runtime variables
    // Shoule be properly handled each time start button pressed

    // State
    // Can be one of the following:
    // Idle: no timer is running
    // RunningActive: timer is running for timing active
    // RunningRest: timer is running for timing rest
    // Paused: timer is pasued
    var state = "Idle"
    // Used when pause is pressed
    var preState = "Idle"


    // Timer
    var timer: Timer = Timer()
    var countHalfSecond: Int = 0
    // The duration for current session(Active/Rest) in second
    var duration: Int = 0
    var rep: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set global variable
        SETTING = (UIApplication.shared.delegate as! AppDelegate).SETTING
        // Copy setting
        updateSetting()

        // reset runtime variables
        initRuntimeVariables()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if state == "Idle" {
            updateSetting()
            initRuntimeVariables()
        }

        // Update UI only
        updateUI()
    }

    // Update setting
    func updateSetting() {
        tmpSetting = Setting(SETTING);
    }

    // Init runtime variables
    func initRuntimeVariables() {
        preState = "Idle"
        state = "Idle"
        countHalfSecond = 0
        duration = tmpSetting.durationActive
        rep = tmpSetting.numberRep
    }

    // Redraw all UI
    func updateUI() {
        updateLabelTimer()
        updateLabelRep()
        updateBackgroundColor()
        updateButtonImage()
    }

    func updateLabelTimer() {
        // Get time
        let (m, s) = Setting.second2MinuteAndSecond(second: duration - countHalfSecond / 2)

        // Padding string with 0
        var secondString = "\(s)"
        if s < 10 {
            secondString = "0" + secondString
        }

        // Flashing second indicator
        if countHalfSecond % 2 == 0 {
            labelTimer.text = "\(m):" + secondString
        } else {
            labelTimer.text = "\(m) " + secondString
        }
    }

    func updateLabelRep() {
        if rep > 1 {
            labelReps.text = "\(rep) rep to go!"
        } else {
            labelReps.text = "Last Rep!"
        }
    }

    func updateBackgroundColor() {
        if state == "RunningActive" {
            UIView.animate(withDuration: 0.5, animations: {
                self.view.backgroundColor = Setting.DICT_COLOR[self.tmpSetting.colorActive]
            })
        } else if state == "RunningRest" {
            UIView.animate(withDuration: 0.5, animations: {
                self.view.backgroundColor = Setting.DICT_COLOR[self.tmpSetting.colorRest]
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.view.backgroundColor = Setting.DICT_COLOR[self.tmpSetting.colorIdle]
            })
        }
    }

    func updateButtonImage() {
        if state == "Idle" || state == "Paused" {
            button.setImage(UIImage(named: "ButtonStart"), for: .normal)
        } else if state == "RunningActive" || state == "RunningRest" {
            button.setImage(UIImage(named: "ButtonPause"), for: .normal)
        }
    }

    // Timer will trigger event once every half second
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: (#selector(MainViewController.updateTimer)), userInfo: nil, repeats: true)
    }

    // Callback func by timer
    @objc func updateTimer() {
        countHalfSecond += 1
        updateLabelTimer()

        if countHalfSecond >= duration * 2 {
            countHalfSecond = -1
            timeUp()
        }
    }

    // Viberate device
    func sendFeedback() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }

    func timeUp() {
        sendFeedback()
        
        if state == "RunningActive" {
            preState = state
            state = "RunningRest"

            // Begin to Rest
            duration = tmpSetting.durationRest
            // Change color
            updateBackgroundColor()
        } else if state == "RunningRest" {
            preState = state
            state = "RunningActive"

            // Start Resting
            duration = tmpSetting.durationActive

            rep -= 1
            updateLabelRep()

            if rep == 0 {
                workoutFinished()
            } else {
                updateBackgroundColor()
            }
        }
    }

    func workoutFinished() {
        timer.invalidate()

        // Popup alert window
        let alert = UIAlertController(title: "Workout Finished", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: { (_: UIAlertAction) in
            self.updateSetting()
            self.initRuntimeVariables()
            self.updateUI()
        }))

        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func btnPressed(_ sender: Any) {
        sendFeedback()
        if state == "Idle" {
            // For every time start button pressed
            // We update the setting
            // and reset all vairables to the latest setting
            updateSetting()
            initRuntimeVariables()

            preState = state
            state = "RunningActive"

            // Update UI to reflect new state
            updateUI()

            // Start the timer
            startTimer()
        } else if state == "RunningActive" || state == "RunningRest" {
            // Pause button pressed
            
            // stop the timer
            timer.invalidate()
            
            preState = state
            state = "Paused"
            
            updateUI()
        } else if state == "Paused" {
            // Resume timer
            startTimer()
            
            state = preState
            preState = "Paused"
            
            updateUI()
        }
    }

}
