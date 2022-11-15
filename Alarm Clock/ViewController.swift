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

    @objc func switchDidChange(_ sender: UISwitch) {
        alarms[sender.tag].active = !alarms[sender.tag].active
        print(alarms[sender.tag])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpTableView()
        
    }

    private func setUpTableView() {
        tableView.dataSource = self
        tableView.register(AlarmTableViewCell.nib(), forCellReuseIdentifier: AlarmTableViewCell.id)
    }
}

