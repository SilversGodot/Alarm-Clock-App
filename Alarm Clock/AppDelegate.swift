//
//  AppDelegate.swift
//  Alarm Clock
//
//  Created by User1 on 11/14/22.
//

import UIKit

var ad = AppDelegate()

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("Setting up categories")
        // Define Actions
        let snoozeAction = UNNotificationAction(identifier: "snooze", title: "Snooze alarm", options: [])
        let dismissAction = UNNotificationAction(identifier: "dismiss", title: "Dismiss alarm", options: [])
        
        
        // Add actions
        let category = UNNotificationCategory(identifier: "alarmCategory", actions: [snoozeAction, dismissAction], intentIdentifiers: [], options: [])
        
        // Add the category to Notification Framwork
        UNUserNotificationCenter.current().setNotificationCategories([category])
        return true
    }
    
    // called when notification options are selected
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // snoozing
        if response.actionIdentifier == "snooze" {
            if let alarm = alarmController.alarms.first(where: {$0.id.uuidString == response.notification.request.identifier}) {
                alarmController.scheduleAlarmSnooze(alarm: alarm)
            }
        }
        // dismiss
        else {
            if let alarm = alarmController.alarms.first(where: {$0.id.uuidString == response.notification.request.identifier}) {
                // only reschedule if the alarm has repeat days
                if (!alarm.repeatDays.isEmpty) {
                    alarmController.rescheduleAlarm(alarm: alarm)
                }
            }
        }
        completionHandler()
    }
    
    // allows notifications while the app is open
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        if let alarm = alarmController.alarms.first(where: {$0.id.uuidString == notification.request.identifier}) {
            // only reschedule if the alarm has repeat days
            if (!alarm.repeatDays.isEmpty) {
                alarmController.rescheduleAlarm(alarm: alarm)
            }
        }
        completionHandler([.banner, .badge, .sound])
    }
    
    // called when a notification is delivered
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, ithCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) async
    {
        if let alarm = alarmController.alarms.first(where: {$0.id.uuidString == response.notification.request.identifier}) {
            // only reschedule if the alarm has repeat days
            if (!alarm.repeatDays.isEmpty) {
                alarmController.rescheduleAlarm(alarm: alarm)
            }
        }
        completionHandler([.banner, .badge, .sound])
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

