//
//  EditAlarmViewController.swift
//  Alarm Clock
//
//  Created by User1 on 11/14/22.
//

import UIKit
import SwiftUI

class EditAlarmViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == snoozeTimeMinutesPicker {
            return maxSnoozeTimeMinutes
        }
        else if pickerView == snoozeTimeSecondsPicker {
            return maxSnoozeTimeSeconds
        }
        else {
            return maxSnoozeCount
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == snoozeTimeMinutesPicker {
            return "\(snoozeTimeMinutesPickerData[row])"
        }
        else if pickerView == snoozeTimeSecondsPicker {
            return "\(snoozeTimeSecondsPickerData[row])"
        }
        else {
            return "\(snoozeCountPickerData[row])"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == snoozeTimeMinutesPicker {
            alarm.snoozeTimeMinutes = row + 1
        }
        else if pickerView == snoozeTimeSecondsPicker {
            alarm.snoozeTimeSeconds = row
        }
        else {
            alarm.snoozeCount = row
        }
    }
    
    var alarm: Alarm!
    let activeButtonColor: UIColor = UIColor.green
    let inactiveButtonColor: UIColor = UIColor.lightGray
    var snoozeCountPickerData: [Int]!
    var snoozeTimeMinutesPickerData: [Int]!
    var snoozeTimeSecondsPickerData: [Int]!
    let minSnoozeCount = 0
    let maxSnoozeCount = 30
    let minSnoozeTimeMinutes = 1
    let maxSnoozeTimeMinutes = 60
    let minSnoozeTimeSeconds = 0
    let maxSnoozeTimeSeconds = 60
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!

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
    @IBOutlet weak var snoozeTimeMinutesPicker: UIPickerView!
    @IBOutlet weak var snoozeTimeSecondsPicker: UIPickerView!
    @IBOutlet weak var snoozeCountPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        alarm = alarmController.currentAlarm
        
        alarmTimePicker.date = alarm.time
        
        snoozeCountPickerData = Array(stride(from: minSnoozeCount, to: maxSnoozeCount + 1, by: 1))
        snoozeTimeMinutesPickerData = Array(stride(from: minSnoozeTimeMinutes, to: maxSnoozeTimeMinutes + 1, by: 1))
        snoozeTimeSecondsPickerData = Array(stride(from: minSnoozeTimeSeconds, to: maxSnoozeTimeSeconds + 1, by: 1))
        
        setTimeLabelText()
        setUpButtons()
        updateButtonColors()
        setUpSnoozePickers()
    }
    
    @IBAction func alarmSwitched(_ sender: Any) {
        alarm.active = !alarm.active
    }
    
    @IBAction func timeChange(_ sender: Any) {
        alarm.time = alarmTimePicker.date
        setTimeLabelText()
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if (alarmController.currentLoc == -1) {
            alarmController.alarms.append(alarm)
        }
        else {
            alarmController.alarms[alarmController.currentLoc] = alarm
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        if (alarmController.currentLoc != -1) {
            alarmController.alarms.remove(at: alarmController.currentLoc)
        }
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
    
    private func setUpSnoozePickers() {
        snoozeCountPicker.dataSource = self
        snoozeCountPicker.delegate = self
        snoozeCountPicker.selectRow(alarm.snoozeCount, inComponent: 0, animated: true)
        
        snoozeTimeMinutesPicker.dataSource = self
        snoozeTimeMinutesPicker.delegate = self
        snoozeTimeMinutesPicker.selectRow(alarm.snoozeTimeMinutes - 1, inComponent: 0, animated: true)
        
        snoozeTimeSecondsPicker.dataSource = self
        snoozeTimeSecondsPicker.delegate = self
        snoozeTimeSecondsPicker.selectRow(alarm.snoozeTimeSeconds, inComponent: 0, animated: true)
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


