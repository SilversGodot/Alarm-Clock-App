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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "hh:mm:ss a"
        df.amSymbol = "AM"
        df.pmSymbol = "PM"
        let now = df.string(from: alarm.time)
        
        let xPad = 10
        var yPad = 100
        
        let labelFrame = CGRect(x: xPad, y: yPad, width: Int(view.frame.width), height: 30)
        yPad += Int(labelFrame.height)
        let sundayButtonFrame = CGRect(x: xPad, y: yPad, width: 30, height: 30)
        let mondayButtonFrame = CGRect(x: xPad + 30, y: yPad, width: 30, height: 30)
        let tuesdayButtonFrame = CGRect(x: xPad + 30 * 2, y: yPad, width: 30, height: 30)
        let wednesdayButtonFrame = CGRect(x: xPad + 30 * 3, y: yPad, width: 30, height: 30)
        let thursdayButtonFrame = CGRect(x: xPad + 30 * 4, y: yPad, width: 30, height: 30)
        let fridayButtonFrame = CGRect(x: xPad + 30 * 5, y: yPad, width: 30, height: 30)
        let saturdayButtonFrame = CGRect(x: xPad + 30 * 6, y: yPad, width: 30, height: 30)
        yPad += Int(sundayButtonFrame.height)
        let timePickerFrame = CGRect(x: xPad, y: yPad, width: Int(view.frame.width), height: 300)
        
        let label = UILabel(frame: labelFrame)
        label.text = now
        
        let sundayButton = UIButton(frame: sundayButtonFrame)
        sundayButton.setTitle("S", for: .normal)
        if alarm.repeatDays.contains("Sunday") {
            sundayButton.backgroundColor = UIColor.blue
        }
        else {
            sundayButton.backgroundColor = UIColor.gray
        }
        sundayButton.layer.cornerRadius = 0.5 * sundayButton.bounds.size.width
        sundayButton.clipsToBounds = true
        
        let mondayButton = UIButton(frame: mondayButtonFrame)
        mondayButton.setTitle("M", for: .normal)
        if alarm.repeatDays.contains("Monday") {
            mondayButton.backgroundColor = UIColor.blue
        }
        else {
            mondayButton.backgroundColor = UIColor.gray
        }
        mondayButton.layer.cornerRadius = 0.5 * sundayButton.bounds.size.width
        mondayButton.clipsToBounds = true
        
        let tuesdayButton = UIButton(frame:tuesdayButtonFrame)
        tuesdayButton.setTitle("T", for: .normal)
        if alarm.repeatDays.contains("Tuesday") {
            tuesdayButton.backgroundColor = UIColor.blue
        }
        else {
            tuesdayButton.backgroundColor = UIColor.gray
        }
        tuesdayButton.layer.cornerRadius = 0.5 * sundayButton.bounds.size.width
        tuesdayButton.clipsToBounds = true
        
        let wednesdayButton = UIButton(frame: wednesdayButtonFrame)
        wednesdayButton.setTitle("W", for: .normal)
        if alarm.repeatDays.contains("Wednesday") {
            wednesdayButton.backgroundColor = UIColor.blue
        }
        else {
            wednesdayButton.backgroundColor = UIColor.gray
        }
        wednesdayButton.layer.cornerRadius = 0.5 * sundayButton.bounds.size.width
        wednesdayButton.clipsToBounds = true
        
        let thursdayButton = UIButton(frame: thursdayButtonFrame)
        thursdayButton.setTitle("T", for: .normal)
        if alarm.repeatDays.contains("Thursday") {
            thursdayButton.backgroundColor = UIColor.blue
        }
        else {
            thursdayButton.backgroundColor = UIColor.gray
        }
        thursdayButton.layer.cornerRadius = 0.5 * sundayButton.bounds.size.width
        thursdayButton.clipsToBounds = true
        
        let fridayButton = UIButton(frame: fridayButtonFrame)
        fridayButton.setTitle("F", for: .normal)
        if alarm.repeatDays.contains("Friday") {
            fridayButton.backgroundColor = UIColor.blue
        }
        else {
            fridayButton.backgroundColor = UIColor.gray
        }
        fridayButton.layer.cornerRadius = 0.5 * sundayButton.bounds.size.width
        fridayButton.clipsToBounds = true
        
        let saturdayButton = UIButton(frame: saturdayButtonFrame)
        saturdayButton.setTitle("S", for: .normal)
        if alarm.repeatDays.contains("Saturday") {
            saturdayButton.backgroundColor = UIColor.blue
        }
        else {
            saturdayButton.backgroundColor = UIColor.gray
        }
        saturdayButton.layer.cornerRadius = 0.5 * sundayButton.bounds.size.width
        saturdayButton.clipsToBounds = true
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(dateChange(timePicker:)), for: UIControl.Event.valueChanged)
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.frame = timePickerFrame
                
        view.addSubview(label)
        view.addSubview(sundayButton)
        view.addSubview(mondayButton)
        view.addSubview(tuesdayButton)
        view.addSubview(wednesdayButton)
        view.addSubview(thursdayButton)
        view.addSubview(fridayButton)
        view.addSubview(saturdayButton)
        view.addSubview(timePicker)
    }
    
    @objc private func dateChange(timePicker: UIDatePicker) {
        alarm.time = timePicker.date
    }
}


