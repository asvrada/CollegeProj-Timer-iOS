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
        if type == "Active" {
            self.navBar.title = "Active Screen Color"
        } else if type == "Rest"{
            self.navBar.title = "Rest Screen Color"
        } else {
            self.navBar.title = "Pause Screen Color"
        }

        picker.dataSource = self
        picker.delegate = self

        SETTING = (UIApplication.shared.delegate as! AppDelegate).SETTING
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Set default value
        if type == "Active" {
            colorView.backgroundColor = Setting.DICT_COLOR[SETTING.colorActive]
            picker.selectRow(Setting.ARRAY_COLOR.index(of: SETTING.colorActive)!, inComponent: 0, animated: false)
        } else if type == "Rest" {
            colorView.backgroundColor = Setting.DICT_COLOR[SETTING.colorRest]
            picker.selectRow(Setting.ARRAY_COLOR.index(of: SETTING.colorRest)!, inComponent: 0, animated: false)
        } else {
            colorView.backgroundColor = Setting.DICT_COLOR[SETTING.colorPaused]
            picker.selectRow(Setting.ARRAY_COLOR.index(of: SETTING.colorPaused)!, inComponent: 0, animated: false)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        colorView.backgroundColor = Setting.DICT_COLOR[Setting.ARRAY_COLOR[row]]
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
