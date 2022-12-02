//
//  ViewController.swift
//  Alarm Clock
//
//  Created by User1 on 11/14/22.
//

import UIKit
import UserNotifications

var alarmController = ViewController()

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
        
    var alarms: [Alarm] = [Alarm(time: Date().addingTimeInterval(120), active: true, repeatDays: ["Monday", "Tuesday"], soundLink: "", snoozeTimeMinutes: 5, snoozeTimeSeconds: 10, snoozeCount: 5, snoozing: false, canSnooze: true),
                           Alarm(time: Date().addingTimeInterval(180), active: false, repeatDays: ["Monday", "Tuesday", "Wednesday"], soundLink: "", snoozeTimeMinutes: 5, snoozeTimeSeconds: 0, snoozeCount: 5, snoozing: false, canSnooze: true)]
    
    let defaultAlarm: Alarm = Alarm(time: Date(), active: true, repeatDays: [""], soundLink: "", snoozeTimeMinutes: 5, snoozeTimeSeconds: 0, snoozeCount: 5, snoozing: false, canSnooze: true)
    
    var currentAlarm: Alarm?
    var currentAlarmCache: Alarm?
    
    var currentLoc: Int = 0
    var currentLocCache: Int = 0
    
    func timeToString(time: Date) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "hh:mm a"
        df.amSymbol = "AM"
        df.pmSymbol = "PM"
        return df.string(from: time)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmController.alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: AlarmTableViewCell.id) as! AlarmTableViewCell
        
        let now = timeToString(time: alarmController.alarms[indexPath.row].time)
        
        myCell.alarmCellLabel.text = now
        myCell.alarmCellSwitch.isOn = alarmController.alarms[indexPath.row].active
        myCell.alarmCellSwitch.tag = indexPath.row
        myCell.alarmCellSwitch.addTarget(self, action: #selector(self.switchDidChange(_:)), for: .valueChanged)
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alarmController.currentAlarm = alarmController.alarms[indexPath.row]
        alarmController.currentAlarmCache = alarmController.alarms[indexPath.row]
        alarmController.currentLoc = indexPath.row
        alarmController.currentLocCache = indexPath.row
    }

    @objc func switchDidChange(_ sender: UISwitch) {
        alarmController.alarms[sender.tag].active = !alarmController.alarms[sender.tag].active
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Alarm Clocks"
        setUpTableView()
        alarmController.currentAlarm = defaultAlarm
        alarmController.currentAlarmCache = defaultAlarm
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { success, error in
            if success {
                // schedule test
                self.scheduleAlarms()
            }
            else if error != nil {
                print("error occurred")
            }
        })
    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBSegueAction func addAlarm(_ coder: NSCoder) -> EditAlarmViewController? {
        alarmController.currentAlarm = defaultAlarm
        alarmController.currentLoc = -1
        return EditAlarmViewController(coder: coder)
    }
    
    @IBSegueAction func editAlarm(_ coder: NSCoder) -> EditAlarmViewController? {
        alarmController.currentAlarm = alarmController.currentAlarmCache
        alarmController.currentLoc = alarmController.currentLocCache
        return EditAlarmViewController(coder: coder)
    }
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AlarmTableViewCell.nib(), forCellReuseIdentifier: AlarmTableViewCell.id)
    }
    
    private func scheduleAlarms() {
        for alarm in alarmController.alarms {
            let content = UNMutableNotificationContent()
            content.title = "Alarm!"
            content.sound = .default
            content.body = timeToString(time: alarm.time)

            let targetDate = alarm.time
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute],
                from: targetDate),
                repeats: false)

            let request = UNNotificationRequest(
                identifier: "alarm " + content.body,
                content: content,
                trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                if error != nil {
                    print("something went wrong")
                }
            })
            print(targetDate)
        }
    }
}

