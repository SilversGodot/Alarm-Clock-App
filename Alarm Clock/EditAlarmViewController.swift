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
    let activeButtonColor: UIColor = UIColor.green
    let inactiveButtonColor: UIColor = UIColor.lightGray
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBOutlet weak var snoozeLabel: UILabel!

    @IBOutlet weak var sundayButton: UIButton!
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var alarmTimePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        alarm = alarmController.currentAlarm
        
        setTimeLabelText()
        setUpButtons()
        updateButtonColors()
    }
    
    @IBAction func alarmSwitched(_ sender: Any) {
        alarm.active = !alarm.active
    }
    
    @IBAction func timeChange(_ sender: Any) {
        alarm.time = alarmTimePicker.date
        setTimeLabelText()
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        alarmController.alarms.append(alarm)
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
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
    
    @IBAction func sundayButtonPressed(_ sender: Any) {
        if alarm.repeatDays.contains("Sunday") {
            alarm.repeatDays.remove("Sunday")
        }
        else {
            alarm.repeatDays.insert("Sunday")
        }
        updateButtonColors()
    }
    
    @IBAction func mondayButtonPressed(_ sender: Any) {
        if alarm.repeatDays.contains("Monday") {
            alarm.repeatDays.remove("Monday")
        }
        else {
            alarm.repeatDays.insert("Monday")
        }
        updateButtonColors()
    }
    
    @IBAction func tuesdayButtonPressed(_ sender: Any) {
        if alarm.repeatDays.contains("Tuesday") {
            alarm.repeatDays.remove("Tuesday")
        }
        else {
            alarm.repeatDays.insert("Tuesday")
        }
        updateButtonColors()
    }
    
    @IBAction func wednesdayButtonPressed(_ sender: Any) {
        if alarm.repeatDays.contains("Wednesday") {
            alarm.repeatDays.remove("Wednesday")
        }
        else {
            alarm.repeatDays.insert("Wednesday")
        }
        updateButtonColors()
    }
    
    @IBAction func thursdayButtonPressed(_ sender: Any) {
        if alarm.repeatDays.contains("Thursday") {
            alarm.repeatDays.remove("Thursday")
        }
        else {
            alarm.repeatDays.insert("Thursday")
        }
        updateButtonColors()
    }
    
    @IBAction func fridayButtonPressed(_ sender: Any) {
        if alarm.repeatDays.contains("Friday") {
            alarm.repeatDays.remove("Friday")
        }
        else {
            alarm.repeatDays.insert("Friday")
        }
        updateButtonColors()
    }
    
    @IBAction func saturdayButtonPressed(_ sender: Any) {
        if alarm.repeatDays.contains("Saturday") {
            alarm.repeatDays.remove("Saturday")
        }
        else {
            alarm.repeatDays.insert("Saturday")
        }
        updateButtonColors()
    }
    
    private func updateButtonColors() {
        if alarm.repeatDays.contains("Sunday") {
            sundayButton.backgroundColor = activeButtonColor
        }
        else {
            sundayButton.backgroundColor = inactiveButtonColor
        }
        
        if alarm.repeatDays.contains("Monday") {
            mondayButton.backgroundColor = activeButtonColor
        }
        else {
            mondayButton.backgroundColor = inactiveButtonColor
        }
        
        if alarm.repeatDays.contains("Tuesday") {
            tuesdayButton.backgroundColor = activeButtonColor
        }
        else {
            tuesdayButton.backgroundColor = inactiveButtonColor
        }
        
        if alarm.repeatDays.contains("Wednesday") {
            wednesdayButton.backgroundColor = activeButtonColor
        }
        else {
            wednesdayButton.backgroundColor = inactiveButtonColor
        }
        
        if alarm.repeatDays.contains("Thursday") {
            thursdayButton.backgroundColor = activeButtonColor
        }
        else {
            thursdayButton.backgroundColor = inactiveButtonColor
        }
        
        if alarm.repeatDays.contains("Friday") {
            fridayButton.backgroundColor = activeButtonColor
        }
        else {
            fridayButton.backgroundColor = inactiveButtonColor
        }
        
        if alarm.repeatDays.contains("Saturday") {
            saturdayButton.backgroundColor = activeButtonColor
        }
        else {
            saturdayButton.backgroundColor = inactiveButtonColor
        }
    }
    
    private func setUpButtons() {
        sundayButton.layer.cornerRadius = 0.5 * sundayButton.bounds.size.width
        sundayButton.clipsToBounds = true
        
        mondayButton.layer.cornerRadius = 0.5 * mondayButton.bounds.size.width
        mondayButton.clipsToBounds = true
        
        tuesdayButton.layer.cornerRadius = 0.5 * tuesdayButton.bounds.size.width
        tuesdayButton.clipsToBounds = true
        
        wednesdayButton.layer.cornerRadius = 0.5 * wednesdayButton.bounds.size.width
        wednesdayButton.clipsToBounds = true
        
        thursdayButton.layer.cornerRadius = 0.5 * thursdayButton.bounds.size.width
        thursdayButton.clipsToBounds = true
        
        fridayButton.layer.cornerRadius = 0.5 * fridayButton.bounds.size.width
        fridayButton.clipsToBounds = true
        
        saturdayButton.layer.cornerRadius = 0.5 * saturdayButton.bounds.size.width
        saturdayButton.clipsToBounds = true
    }
}


