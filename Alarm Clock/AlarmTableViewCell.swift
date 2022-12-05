//
//  AlarmTableViewCell.swift
//  Alarm Clock
//
//  Created by User1 on 11/14/22.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {

    @IBOutlet weak var alarmCellLabel: UILabel!
    @IBOutlet weak var alarmCellSwitch: UISwitch!
    
    public static var id = "alarmCell"
    
    public var alarm: Alarm!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func switchChange(_ sender: UISwitch) {

    }
    
    @IBAction func earlyDismissPress(_ sender: Any) {
        // early dismiss schedule
        alarmController.scheduleAlarmEarlyDismiss(alarm: alarm)
    }
    
    @IBAction func snoozePress(_ sender: Any) {
        // snooze schedule
        alarmController.scheduleAlarmSnooze(alarm: alarm)
    }
    
    public static func nib() -> UINib {
        return UINib(nibName: "AlarmTableViewCell", bundle: nil)
    }
}
