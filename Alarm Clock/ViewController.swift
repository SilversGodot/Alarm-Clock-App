//
//  ViewController.swift
//  Alarm Clock
//
//  Created by User1 on 11/14/22.
//

import UIKit

var alarmController = ViewController()

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
        
    var alarms: [Alarm] = [Alarm(time: Date(), active: true, repeatDays: ["Monday"], soundLink: "", snoozeTimeMinutes: 5, snoozeTimeSeconds: 10, snoozeCount: 5, snoozing: false, canSnooze: true), Alarm(time: Date(), active: false, repeatDays: ["Monday", "Tuesday", "Wednesday"], soundLink: "", snoozeTimeMinutes: 5, snoozeTimeSeconds: 0, snoozeCount: 5, snoozing: false, canSnooze: true)]
    
    let defaultAlarm: Alarm = Alarm(time: Date(), active: true, repeatDays: [""], soundLink: "", snoozeTimeMinutes: 5, snoozeTimeSeconds: 0, snoozeCount: 5, snoozing: false, canSnooze: true)
    
    var currentAlarm: Alarm?
    var currentAlarmCache: Alarm?
    
    var currentLoc: Int = 0
    var currentLocCache: Int = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: AlarmTableViewCell.id) as! AlarmTableViewCell
        
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "hh:mm:ss a"
        df.amSymbol = "AM"
        df.pmSymbol = "PM"
        let now = df.string(from: alarms[indexPath.row].time)
        
        myCell.alarmCellLabel.text = now
        myCell.alarmCellSwitch.isOn = alarms[indexPath.row].active
        myCell.alarmCellSwitch.tag = indexPath.row
        myCell.alarmCellSwitch.addTarget(self, action: #selector(self.switchDidChange(_:)), for: .valueChanged)
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alarmController.currentAlarm = alarms[indexPath.row]
        alarmController.currentAlarmCache = alarms[indexPath.row]
        alarmController.currentLoc = indexPath.row
        alarmController.currentLocCache = indexPath.row
    }

    @objc func switchDidChange(_ sender: UISwitch) {
        alarms[sender.tag].active = !alarms[sender.tag].active
        print(alarms[sender.tag])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Alarm Clocks"
        setUpTableView()
        alarmController.currentAlarm = defaultAlarm
        alarmController.currentAlarmCache = defaultAlarm
    }
    override func viewWillAppear(_ animated: Bool) {
        print(alarmController.alarms)
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
}

