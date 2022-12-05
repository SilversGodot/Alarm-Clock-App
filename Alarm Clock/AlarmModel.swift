//
//  AlarmModel.swift
//  Alarm Clock
//
//  Created by User1 on 11/14/22.
//

import UIKit

struct Alarm: Encodable, Decodable {
    var id: UUID
    
    var time: Date
    var active: Bool
    var repeatDays: Set<Int>
    
    var soundURL: String
    var fileDownloaded: Bool
    
    var canSnooze: Bool
    var snoozing: Bool
    var snoozeTimeMinutes: Int
    var snoozeTimeSeconds: Int
    var snoozeCountMax: Int
    var snoozeCountCurrent: Int
}
