//
//  NumberPickerViewController.swift
//  HITs
//
//  Created by WuZiJie on 2017/11/14.
//  Copyright © 2017年 TBD. All rights reserved.
//

import UIKit

class NumberPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var picker: UIPickerView!

    var pickerData: [String] = []
    var pickerLabel: [String] = []
    var SETTING = (UIApplication.shared.delegate as! AppDelegate).SETTING

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        picker.dataSource = self
        picker.delegate = self
        pickerData = Setting.generateStringList(min: 1, max: 20)
        pickerLabel = ["Repeats"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set default value for picker
        picker.selectRow(SETTING.numberRep - 1, inComponent: 0, animated: false)
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            SETTING.numberRep = row + 1
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return pickerData.count
        } else {
            return pickerLabel.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return pickerData[row]
        } else {
            return pickerLabel[0]
        }
    }

}
