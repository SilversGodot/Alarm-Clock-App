//
//  ViewController.swift
//  Alarm Clock
//
//  Created by User1 on 11/14/22.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var alarms: [Alarm] = [Alarm(time: Date(), active: true, repeatDays: ["Monday"], soundLink: "", snoozeTime: 600, snoozeCount: 5, snoozing: false), Alarm(time: Date(), active: false, repeatDays: ["Monday"], soundLink: "", snoozeTime: 600, snoozeCount: 5, snoozing: false)]
    
    var currentAlarm: Alarm?
    
    let defaultAlarm: Alarm = Alarm(time: Date(), active: true, repeatDays: ["Monday"], soundLink: "", snoozeTime: 600, snoozeCount: 5, snoozing: false)
    
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
        currentAlarm = alarms[indexPath.row]
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
        configureItems()
    }

    private func setUpTableView() {
        tableView.dataSource = self
        tableView.register(AlarmTableViewCell.nib(), forCellReuseIdentifier: AlarmTableViewCell.id)
    }
    
    private func configureItems() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAlarm(sender:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editAlarm(sender:)))
    }
    
    @objc private func addAlarm(sender: UIBarButtonItem) {
        let editVC = EditAlarmViewController()
        editVC.alarm = defaultAlarm
        
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    @objc private func editAlarm(sender: UIBarButtonItem) {
        
    }
}

