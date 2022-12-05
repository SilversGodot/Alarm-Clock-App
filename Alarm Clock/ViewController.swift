//
//  ViewController.swift
//  Alarm Clock
//
//  Created by User1 on 11/14/22.
//

import UIKit
import UserNotifications

var alarmController = ViewController()

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var alarms: [Alarm] = [
//        Alarm(id: UUID(), time: Date().addingTimeInterval(60), active: true, repeatDays: [""], soundURL: "https://cvws.icloud-content.com/B/AYVCoYKEGEn3OiB1CjFh10JGD99WAaXqXaKa5FPKT5GXQSlHhrHu9dR6/bell.wav?o=ApFqI4YGqu_FcyXF1d30KSJ79-2IRFXvwx1AxVseeZtf&v=1&x=3&a=CAog2BZzzcQxhFBL38sjXXZaOOG4H_CDsoCXnvmM9fNr3z4SbxD7va74zTAY-5qK-s0wIgEAUgRGD99WWgTu9dR6aieazvtF4bNgs2B7MGaZI-vPf1oqT-FTyaPfHI3SZjIc8v7nVwQLdaJyJ97uqiTOZy1Qp0E4bxNB7_k5UVQ8L33Qj17M6xIlY6x3MhkWZvZwhg&e=1670192991&fl=&r=b0c18db6-1a9a-4ae2-b982-08710d2cdb6d-1&k=618lgBWWbBBLbooUcwYMmA&ckc=com.apple.clouddocs&ckz=com.apple.CloudDocs&p=116&s=hGpsEZfFRHFTpINuBeLBq1zlCxw&cd=i", fileDownloaded: false, canSnooze: true, snoozing: false, snoozeTimeMinutes: 5, snoozeTimeSeconds: 0, snoozeCountMax: 5, snoozeCountCurrent: 0)
//        Alarm(time: Date().addingTimeInterval(120), active: false, repeatDays: ["Monday", "Tuesday", "Wednesday"], soundURL: "", soundPath: "", fileDownloaded: false, snoozeTimeMinutes: 5, snoozeTimeSeconds: 0, snoozeCountMax: 5, snoozeCountCurrent: 0, snoozing: false, canSnooze: true)
    ]
    
    var defaultAlarm: Alarm = Alarm(id: UUID(), time: Date(), active: true, repeatDays: [], soundURL: "", fileDownloaded: false, canSnooze: true, snoozing: false, snoozeTimeMinutes: 5, snoozeTimeSeconds: 0, snoozeCountMax: 5, snoozeCountCurrent: 0)
    
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
        
        myCell.alarm = alarmController.alarms[indexPath.row]
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    @objc func switchDidChange(_ sender: UISwitch) {
        alarmController.alarms[sender.tag].active = sender.isOn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Alarm Clocks"
        
        fetchAlarms()
        setUpTableView()
        alarmController.currentAlarm = defaultAlarm
        alarmController.currentAlarmCache = defaultAlarm
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { success, error in
            if success {
                // schedule test
                UNUserNotificationCenter.current().delegate = self
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
        defaultAlarm.id = UUID()
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
            scheduleAlarm(alarm: alarm)
        }
    }
    
    func fetchAlarms() {
        let loadURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("data")
            .appendingPathExtension("plist")
        do {
            let plistData = try Data(contentsOf: loadURL)
            let alarmLoad = try PropertyListDecoder().decode(Array<Alarm>.self, from: plistData)
            alarmController.alarms = alarmLoad
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveAlarms() {
        let saveURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("data")
            .appendingPathExtension("plist")
        do {
            let encodedData = try PropertyListEncoder().encode(alarms)
            try encodedData.write(to: saveURL)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // schedules an individual alarm
    func scheduleAlarm(alarm: Alarm) {
        if (!alarm.active) {
            return;
        }
        
        if (alarm.soundURL != "") {
            downloadSoundFile(alarm: alarm)
        }
        
        // specifies notification content
        let content = UNMutableNotificationContent()
        content.title = "Alarm!"
        // sound file must be in Library/Sounds
        content.sound = UNNotificationSound(named: UNNotificationSoundName(alarm.id.uuidString))
        content.body = timeToString(time: alarm.time)
        
        let targetDate = alarm.time
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute],
            from: targetDate),
            repeats: false)

        let request = UNNotificationRequest(
            identifier: alarm.id.uuidString,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print("something went wrong")
            }
        })
    }
    
    func scheduleAlarmSnooze(alarm: Alarm) {
        if (!alarm.active) {
            return;
        }
        
        if (!alarm.canSnooze || alarm.snoozeCountCurrent >= alarm.snoozeCountMax) {
            return
        }
        
        var newAlarm = alarm
        newAlarm.snoozeCountCurrent += 1
        newAlarm.time = alarm.time.advanced(by: TimeInterval(alarm.snoozeTimeMinutes * 60 + alarm.snoozeTimeSeconds))
        
        scheduleAlarm(alarm: newAlarm)
    }
    
    func scheduleAlarmEarlyDismiss(alarm: Alarm) {
        unscheduleAlarm(s: alarm.id.uuidString)
        
        if (!alarm.active) {
            return;
        }
        
        // one-time alarm does not need to be rescheduled
        if (alarm.repeatDays.isEmpty) {
            return
        }

        let currentDay = alarm.time.dayNumberOfWeek()!
        var i: Int = 0
        
        let sortedRepeatedDays = alarm.repeatDays.sorted()
        
        for day in sortedRepeatedDays {
            if day > currentDay {
                break;
            }
            i += 1
        }
        
        i = i % alarm.repeatDays.count
        
        let prevDay = currentDay
        let newDay = sortedRepeatedDays[i]
        var dayDiff = newDay - prevDay
        if dayDiff <= 0 {
            dayDiff += 7
        }
        
        var newAlarm = alarm
        newAlarm.time = alarm.time.advanced(by: TimeInterval(dayDiff * 60 * 60 * 24))

        scheduleAlarm(alarm: newAlarm)
    }
    
    // unschedules an individual alarm
    func unscheduleAlarm(s: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [s])
    }
    
    func downloadSoundFile(alarm: Alarm) {
        do {
            let targetURL = try FileManager.default.soundsLibraryURL(for: alarm.id.uuidString)
            if !FileManager.default.fileExists(atPath: targetURL.absoluteString) {
                let url = URL(string: alarm.soundURL)
                
                let downloadTask = URLSession.shared.downloadTask(with: url!) {
                    urlOrNil, responseOrNil, errorOrNil in
                    // check for and handle errors:
                    // * errorOrNil should be nil
                    // * responseOrNil should be an HTTPURLResponse with statusCode in 200..<299
                    
                    guard let fileURL = urlOrNil else { return }
                    do {
                        let targetURL = try FileManager.default.soundsLibraryURL(for: alarm.id.uuidString)
                        try FileManager.default.moveItem(at: fileURL, to: targetURL)
                    } catch {
                        print ("file error: \(error)")
                    }
                }
                downloadTask.resume()
            }

        } catch {
            print ("file error: \(error)")
        }
    }
    
    // allows notifications while the app is open
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.banner, .badge, .sound])
    }
    
    func dayToInt(day: String) -> Int {
        var res: Int = 0
        switch day {
        case "Sunday":
            res = 1
        case "Monday":
            res = 2
        case "Tuesday":
            res = 3
        case "Wednesday":
            res = 4
        case "Thursday":
            res = 5
        case "Friday":
            res = 6
        case "Saturday":
            res = 7
        default:
            res = 0
        }
        
        return res
    }
    
    func intToDay(day: Int) -> String {
        var res: String = ""
        switch day {
        case 1:
            res = "Sunday"
        case 2:
            res = "Monday"
        case 3:
            res = "Tuesday"
        case 4:
            res = "Wednesday"
        case 5:
            res = "Thursday"
        case 6:
            res = "Friday"
        case 7:
            res = "Saturday"
        default:
            res = ""
        }
        
        return res
    }
}

// finds the file path to Library/Sounds
extension FileManager {
    func soundsLibraryURL(for filename: String) throws -> URL {
        let libraryURL = try url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let soundFolderURL = libraryURL.appendingPathComponent("Sounds", isDirectory: true)
        if !fileExists(atPath: soundFolderURL.path) {
            try createDirectory(at: soundFolderURL, withIntermediateDirectories: true)
        }
        return soundFolderURL.appendingPathComponent(filename, isDirectory: false)
    }
}

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}
