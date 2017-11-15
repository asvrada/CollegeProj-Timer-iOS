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
        pickerDataMinute = generateStringList(max: 60)
        pickerDataSecond = generateStringList(max: 59)

        // Set delegate
        picker.dataSource = self
        picker.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        var time = 0

        // Set default value
        if type == "Active" {
            time = SETTING.durationActive
        } else {
            time = SETTING.durationRest
        }

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Generate a list of string that represents int from 1 to max
    func generateStringList(max: Int) -> [String] {
        return (0...max).map { "\($0)" }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // Minute
        if component == 0 {
            return pickerDataMinute.count
        } else if component == 1 {
            return pickerDataSecond.count
        }

        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return pickerDataMinute[row]
        } else if component == 1 {
            return pickerDataSecond[row]
        }

        return ""
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
