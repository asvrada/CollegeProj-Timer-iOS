//
//  SettingTableViewController.swift
//  HITs
//
//  Created by WuZiJie on 2017/11/15.
//  Copyright © 2017年 TBD. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {
    @IBOutlet weak var labelActive: UILabel!
    @IBOutlet weak var labelRest: UILabel!
    @IBOutlet weak var labelReps: UILabel!

    @IBOutlet weak var labelColorActive: UILabel!
    @IBOutlet weak var labelColorRest: UILabel!
    @IBOutlet weak var labelColorPause: UILabel!

    var SETTING: Setting = Setting()

    override func viewDidLoad() {
        super.viewDidLoad()

        SETTING = (UIApplication.shared.delegate as! AppDelegate).SETTING

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // Init the detail labels
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let (aM, aS) = Setting.second2MinuteAndSecond(second: SETTING.durationActive)
        let (rM, rS) = Setting.second2MinuteAndSecond(second: SETTING.durationRest)

        labelActive.text = "\(aM):\(aS)"
        labelRest.text = "\(rM):\(rS)"
        labelReps.text = "\(SETTING.numberRep)"
        labelColorActive.text = SETTING.colorActive
        labelColorRest.text = SETTING.colorRest
        labelColorPause.text = SETTING.colorPaused
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // WORKOUT
        if indexPath.section == 0 {
            // Skip when Rep cell pressed
            if indexPath.row != 2 {
                performSegue(withIdentifier: "segueSetDuration", sender: self)
            }
        }

        // COLOR
        if indexPath.section == 1 {
            performSegue(withIdentifier: "segueSetColor", sender: self)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueSetDuration" {
            let selectedRow = self.tableView.indexPathForSelectedRow!
            let dest = segue.destination as! DurationViewController
            dest.type = selectedRow.row == 0 ? "Active" : "Rest"
        }

        if segue.identifier == "segueSetColor" {
            let selectedRow = self.tableView.indexPathForSelectedRow!
            let dest = segue.destination as! ColorViewController
            let type = [
                0: "Active",
                1: "Rest",
                2: "Pause"
            ]
            dest.type = type[selectedRow.row]!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let map = [
            0: 3,
            1: 3,
            2: 1
        ]

        return map[section]!
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
