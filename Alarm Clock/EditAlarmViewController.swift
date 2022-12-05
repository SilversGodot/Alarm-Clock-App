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
            alarm.snoozeCountMax = row
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
    
    @IBOutlet weak var snoozeSwitch: UISwitch!
    @IBOutlet weak var snoozeTimeMinutesPicker: UIPickerView!
    @IBOutlet weak var snoozeTimeSecondsPicker: UIPickerView!
    @IBOutlet weak var snoozeCountPicker: UIPickerView!
    
    @IBOutlet weak var soundLink: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        alarm = alarmController.currentAlarm
        
        print(alarm)
        
        alarmTimePicker.date = alarm.time
        soundLink.text = alarm.soundURL
        
        snoozeCountPickerData = Array(stride(from: minSnoozeCount, to: maxSnoozeCount + 1, by: 1))
        snoozeTimeMinutesPickerData = Array(stride(from: minSnoozeTimeMinutes, to: maxSnoozeTimeMinutes + 1, by: 1))
        snoozeTimeSecondsPickerData = Array(stride(from: minSnoozeTimeSeconds, to: maxSnoozeTimeSeconds + 1, by: 1))
        
        setTimeLabelText()
        setUpSoundLink()
        setUpButtons()
        updateButtonColors()
        setUpSnoozePickers()
        setUpSwitches();
    }
    
    @IBAction func alarmSwitched(_ sender: Any) {
        alarm.active = alarmSwitch.isOn
    }
    
    @IBAction func snoozeSwitched(_ sender: Any) {
        alarm.canSnooze = snoozeSwitch.isOn
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
            alarmController.unscheduleAlarm(s: alarm.id.uuidString)
        }
        alarmController.unscheduleAlarm(s: alarm.id.uuidString)
        alarmController.scheduleAlarm(alarm: alarm)
        alarmController.saveAlarms()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        if (alarmController.currentLoc != -1) {
            alarmController.alarms.remove(at: alarmController.currentLoc)
            alarmController.unscheduleAlarm(s: alarm.id.uuidString)
            alarmController.saveAlarms()
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
    
    private func setUpSoundLink() {
        soundLink.text = alarm.soundURL
    }
    
    @IBAction func updateSoundLinkValue(_ sender: Any) {
        alarm.soundURL = soundLink.text!
    }
    
    private func setUpSnoozePickers() {
        snoozeCountPicker.dataSource = self
        snoozeCountPicker.delegate = self
        snoozeCountPicker.selectRow(alarm.snoozeCountMax, inComponent: 0, animated: true)
        
        snoozeTimeMinutesPicker.dataSource = self
        snoozeTimeMinutesPicker.delegate = self
        snoozeTimeMinutesPicker.selectRow(alarm.snoozeTimeMinutes - 1, inComponent: 0, animated: true)
        
        snoozeTimeSecondsPicker.dataSource = self
        snoozeTimeSecondsPicker.delegate = self
        snoozeTimeSecondsPicker.selectRow(alarm.snoozeTimeSeconds, inComponent: 0, animated: true)
    }
    
    @IBAction func sundayButtonPressed(_ sender: Any) {
        if alarm.repeatDays.contains(1) {
            alarm.repeatDays.remove(1)
        }
        else {
            alarm.repeatDays.insert(1)
        }
        updateButtonColors()
    }
    
    @IBAction func mondayButtonPressed(_ sender: Any) {
        if alarm.repeatDays.contains(2) {
            alarm.repeatDays.remove(2)
        }
        else {
            alarm.repeatDays.insert(2)
        }
        updateButtonColors()
    }
    
    @IBAction func tuesdayButtonPressed(_ sender: Any) {
        if alarm.repeatDays.contains(3) {
            alarm.repeatDays.remove(3)
        }
        else {
            alarm.repeatDays.insert(3)
        }
        updateButtonColors()
    }
    
    @IBAction func wednesdayButtonPressed(_ sender: Any) {
        if alarm.repeatDays.contains(4) {
            alarm.repeatDays.remove(4)
        }
        else {
            alarm.repeatDays.insert(4)
        }
        updateButtonColors()
    }
    
    @IBAction func thursdayButtonPressed(_ sender: Any) {
        if alarm.repeatDays.contains(5) {
            alarm.repeatDays.remove(5)
        }
        else {
            alarm.repeatDays.insert(5)
        }
        updateButtonColors()
    }
    
    @IBAction func fridayButtonPressed(_ sender: Any) {
        if alarm.repeatDays.contains(6) {
            alarm.repeatDays.remove(6)
        }
        else {
            alarm.repeatDays.insert(6)
        }
        updateButtonColors()
    }
    
    @IBAction func saturdayButtonPressed(_ sender: Any) {
        if alarm.repeatDays.contains(7) {
            alarm.repeatDays.remove(7)
        }
        else {
            alarm.repeatDays.insert(7)
        }
        updateButtonColors()
    }
    
    private func setUpSwitches() {
        alarmSwitch.setOn(alarm.active, animated: true)
        snoozeSwitch.setOn(alarm.canSnooze, animated: false)
    }
    
    private func updateButtonColors() {
        if alarm.repeatDays.contains(1) {
            sundayButton.backgroundColor = activeButtonColor
        }
        else {
            sundayButton.backgroundColor = inactiveButtonColor
        }
        
        if alarm.repeatDays.contains(2) {
            mondayButton.backgroundColor = activeButtonColor
        }
        else {
            mondayButton.backgroundColor = inactiveButtonColor
        }
        
        if alarm.repeatDays.contains(3) {
            tuesdayButton.backgroundColor = activeButtonColor
        }
        else {
            tuesdayButton.backgroundColor = inactiveButtonColor
        }
        
        if alarm.repeatDays.contains(4) {
            wednesdayButton.backgroundColor = activeButtonColor
        }
        else {
            wednesdayButton.backgroundColor = inactiveButtonColor
        }
        
        if alarm.repeatDays.contains(5) {
            thursdayButton.backgroundColor = activeButtonColor
        }
        else {
            thursdayButton.backgroundColor = inactiveButtonColor
        }
        
        if alarm.repeatDays.contains(6) {
            fridayButton.backgroundColor = activeButtonColor
        }
        else {
            fridayButton.backgroundColor = inactiveButtonColor
        }
        
        if alarm.repeatDays.contains(7) {
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


