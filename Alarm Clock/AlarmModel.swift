//
//  AlarmModel.swift
//  Alarm Clock
//
//  Created by User1 on 11/14/22.
//

import UIKit

struct Alarm {
    var time: Date
    var active: Bool
    var repeatDays: Set<String>
    var soundLink: String
    var snoozeTime: Int
    var snoozeCount: Int
    var snoozing: Bool
}