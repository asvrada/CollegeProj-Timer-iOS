//
//  ColorViewController.swift
//  HITs
//
//  Created by WuZiJie on 2017/11/15.
//  Copyright © 2017年 TBD. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var picker: UIPickerView!

    @IBOutlet weak var colorView: UIView!

    // Set by segue
    var type = "Active"

    var SETTING = Setting()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let map = [
            "Active": "Active Screen Color",
            "Rest": "Rest Screen Color",
            "Pause": "Pause Screen Color"
        ]
        self.navBar.title = map[type]!

        picker.dataSource = self
        picker.delegate = self

        SETTING = (UIApplication.shared.delegate as! AppDelegate).SETTING
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let map:[String:String] = [
            "Active": SETTING.colorActive,
            "Rest": SETTING.colorRest,
            "Pause": SETTING.colorPaused
        ]
        let color:String = map[type]!

        colorView.backgroundColor = Setting.DICT_COLOR[color]
        picker.selectRow(Setting.ARRAY_COLOR.index(of: color)!, inComponent: 0, animated: false)
    }

    // Callback on selected value
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Change the background color of preview view
        colorView.backgroundColor = Setting.DICT_COLOR[Setting.ARRAY_COLOR[row]]
        
        // Update the setting
        if type == "Active" {
            SETTING.colorActive = Setting.ARRAY_COLOR[row]
        } else if type == "Rest" {
            SETTING.colorRest = Setting.ARRAY_COLOR[row]
        } else {
            SETTING.colorPaused = Setting.ARRAY_COLOR[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Setting.ARRAY_COLOR[row]
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Setting.ARRAY_COLOR.count
    }

}
