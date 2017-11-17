//
//  DurationViewController.swift
//  HITs
//
//  Created by WuZiJie on 2017/11/14.
//  Copyright © 2017年 TBD. All rights reserved.
//

import UIKit

class DurationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var picker: UIPickerView!

    var SETTING: Setting = Setting()

    // set by segue
    var type = "Active"

    var pickerDataMinute: [String] = []
    var pickerDataSecond: [String] = []

    var selectMinute = 0
    var selectSecond = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // Set title accordingly
        if type == "Active" {
            self.navBar.title = "Active Duration"
        } else {
            self.navBar.title = "Rest Duration"
        }

        // Init data
        SETTING = (UIApplication.shared.delegate as! AppDelegate).SETTING
        pickerDataMinute = Setting.generateStringList(min: 0, max: 60)
        pickerDataSecond = Setting.generateStringList(min: 0, max: 59)

        // Set delegate
        picker.dataSource = self
        picker.delegate = self
    }

    // Set the screen to Active or Rest screen
    // Init the screen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let time = type == "Active" ? SETTING.durationActive : SETTING.durationRest

        // Set default value for this screen
        (selectMinute, selectSecond) = Setting.second2MinuteAndSecond(second: time)

        picker.selectRow(selectMinute, inComponent: 0, animated: false)
        picker.selectRow(selectSecond, inComponent: 1, animated: false)
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectMinute = row
        } else if component == 1 {
            selectSecond = row
        }

        if selectMinute == 0 && selectSecond == 0 {
            selectSecond = 1
        }

        // Update duration
        if type == "Active" {
            SETTING.durationActive = selectMinute * 60 + selectSecond
        } else {
            SETTING.durationRest = selectMinute * 60 + selectSecond
        }

    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // Return number of possible values for Minute or Second
        return component == 0 ? pickerDataMinute.count : pickerDataSecond.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // Return value ar given index of Minute or Second array
        return component == 0 ? pickerDataMinute[row] : pickerDataSecond[row]
    }

}
