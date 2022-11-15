//
//  EditAlarmViewController.swift
//  Alarm Clock
//
//  Created by User1 on 11/14/22.
//

import UIKit
import SwiftUI

class EditAlarmViewController: UIViewController {
    var alarm: Alarm!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var sundayButton: UIButton!
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        alarm = alarmController.currentAlarm
        
        setTimeLabelText()
        
        let xPad = 10
        var yPad = 100
        
        let labelFrame = CGRect(x: xPad, y: yPad, width: Int(view.frame.width), height: 30)
        yPad += Int(labelFrame.height)
        yPad += Int(sundayButton.frame.size.height)
        let timePickerFrame = CGRect(x: xPad, y: yPad, width: Int(view.frame.width), height: 300)

        setButtonColors()
    }
    
    @IBAction func timeChange(_ sender: Any) {
        alarm.time = timePicker.date
        setTimeLabelText()
    }
    
    private func setTimeLabelText() {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "hh:mm a"
        df.amSymbol = "AM"
        df.pmSymbol = "PM"
        let time = df.string(from: alarm.time)
        timeLabel.text = time
    }
    
    private func setButtonColors() {
        if alarm.repeatDays.contains("Sunday") {
            sundayButton.backgroundColor = UIColor.blue
        }
        else {
            sundayButton.backgroundColor = UIColor.lightGray
        }
        sundayButton.layer.cornerRadius = 0.5 * sundayButton.bounds.size.width
        sundayButton.clipsToBounds = true
        
        if alarm.repeatDays.contains("Monday") {
            mondayButton.backgroundColor = UIColor.green
        }
        else {
            mondayButton.backgroundColor = UIColor.lightGray
        }
        mondayButton.layer.cornerRadius = 0.5 * mondayButton.bounds.size.width
        mondayButton.clipsToBounds = true
        
        if alarm.repeatDays.contains("Tuesday") {
            tuesdayButton.backgroundColor = UIColor.blue
        }
        else {
            tuesdayButton.backgroundColor = UIColor.lightGray
        }
        tuesdayButton.layer.cornerRadius = 0.5 * tuesdayButton.bounds.size.width
        tuesdayButton.clipsToBounds = true
        
        if alarm.repeatDays.contains("Wednesday") {
            wednesdayButton.backgroundColor = UIColor.blue
        }
        else {
            wednesdayButton.backgroundColor = UIColor.lightGray
        }
        wednesdayButton.layer.cornerRadius = 0.5 * wednesdayButton.bounds.size.width
        wednesdayButton.clipsToBounds = true
        
        if alarm.repeatDays.contains("Thursday") {
            thursdayButton.backgroundColor = UIColor.blue
        }
        else {
            thursdayButton.backgroundColor = UIColor.lightGray
        }
        thursdayButton.layer.cornerRadius = 0.5 * thursdayButton.bounds.size.width
        thursdayButton.clipsToBounds = true
        
        if alarm.repeatDays.contains("Friday") {
            fridayButton.backgroundColor = UIColor.blue
        }
        else {
            fridayButton.backgroundColor = UIColor.lightGray
        }
        fridayButton.layer.cornerRadius = 0.5 * fridayButton.bounds.size.width
        fridayButton.clipsToBounds = true
        
        if alarm.repeatDays.contains("Saturday") {
            saturdayButton.backgroundColor = UIColor.blue
        }
        else {
            saturdayButton.backgroundColor = UIColor.lightGray
        }
        saturdayButton.layer.cornerRadius = 0.5 * saturdayButton.bounds.size.width
        saturdayButton.clipsToBounds = true
    }
}


