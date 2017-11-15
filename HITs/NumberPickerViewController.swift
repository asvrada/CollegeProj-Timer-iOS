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
        pickerData = generateStringList(max: 20)
        pickerLabel = ["Repeats"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set default value for picker
        picker.selectRow(SETTING.numberRep - 1, inComponent: 0, animated: false)
    }

    // Generate a list of string that represents int from 1 to max
    func generateStringList(max: Int) -> [String] {
        return (1...max).map { "\($0)" }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
