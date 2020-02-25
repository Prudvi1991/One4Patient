//
//  UserNotifications.swift
//  One for Patient
//
//  Created by Idontknow on 10/02/20.
//  Copyright © 2020 AnnantaSourceLLc. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications


struct notifyDetails {
    var name:String
    var msg:String
    
}

struct Notifications {
    var id:String
    var title:String
    var datetime:DateComponents
}

class LocalNotificationManager
{
    var notifications = [Notifications]()
    
    
    func listScheduledNotifications()
    {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in

            for notification in notifications {
                print(notification)
            }
        }
    }
    
    private func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in

            if granted == true && error == nil {
                self.scheduleNotifications()
            }
        }
    }
    
    func schedule() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in

            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization()
            case .authorized, .provisional:
                self.scheduleNotifications()
            default:
                break // Do nothing
            }
        }
    }
    
    private func scheduleNotifications(){
        for notification in notifications
        {
            let content      = UNMutableNotificationContent()
            content.title    = notification.title
            content.sound    = .default

            let trigger = UNCalendarNotificationTrigger(dateMatching: notification.datetime, repeats: false)

            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in

                guard error == nil else { return }

                print("Notification scheduled! --- ID = \(notification.id)")
            }
        }
    }
    
    
    func registerNotifcations() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .appointmentCreated, object: nil)

        
    }
    
    @objc func onDidReceiveData(_ notification:Notification) {
        // Do something now
    }

}




extension Notification.Name {
    static let appointmentCreated = Notification.Name("appointmentCreated")
}
