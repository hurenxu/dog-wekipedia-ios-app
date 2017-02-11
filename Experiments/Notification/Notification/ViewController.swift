//
//  ViewController.swift
//  Notification
//
//  Created by Kim Jasper Mui on 2/10/17.
//  Copyright © 2017 Kim Jasper Mui. All rights reserved.
//

import UIKit
import UserNotifications


class ViewController: UIViewController {

    // figure out how to reset view when entering from background
    
    
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var reminderStatus: UILabel!
    
    var notificationContent = UNMutableNotificationContent()


    // this is an event user scrolls to select a time
    @IBAction func timeChanged(_ sender: Any) {
    
        reminderStatus.text = "Reminder is off"
        notificationSwitch.setOn(false, animated: true)
    }

    // this is an event when the switch changes state
    @IBAction func switchEvent(_ sender: Any) {
        
        // switch is on, remind 15 seconds before
        if notificationSwitch.isOn {
        
            print("Switch On")
            reminderStatus.text = "Reminder is on"
            
            // notification's content
            notificationContent.title = "Vaccination Date Reminder"
            notificationContent.body = "Vaccination Date is in 30 seconds!"
            notificationContent.badge = 1
            notificationContent.sound = UNNotificationSound.default()
            notificationContent.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
            
            // obtain the date and time user chooses
            var adjustedDate = datePicker.date
            
            // 0 out the second then subtract 30 seconds
            adjustedDate -= adjustedDate.timeIntervalSince1970.truncatingRemainder(dividingBy: 60.0)
            adjustedDate -= 30.0
            
            // set the notification time
            var notificationTime = DateComponents()
            notificationTime.year = datePicker.calendar.component(Calendar.Component.year, from: adjustedDate)
            notificationTime.month = datePicker.calendar.component(Calendar.Component.month, from: adjustedDate)
            notificationTime.day = datePicker.calendar.component(Calendar.Component.day, from: adjustedDate)
            notificationTime.hour = datePicker.calendar.component(Calendar.Component.hour, from: adjustedDate)
            notificationTime.minute = datePicker.calendar.component(Calendar.Component.minute, from: adjustedDate)
            notificationTime.second = datePicker.calendar.component(Calendar.Component.second, from: adjustedDate)
            
            // send notification at this time
            let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: false)
        
            // requesting notification
            let notificationRequest = UNNotificationRequest(identifier: "VaccinationReminder", content:notificationContent, trigger: notificationTrigger)
        
            // the notification center for displaying the notification
            UNUserNotificationCenter.current().add(notificationRequest) { (error : Error?) in
            
                if let theError = error {
                
                    print(theError.localizedDescription)
                }
            }
        }
        
        // switch is off, remove the reminder if any
        else {
            
            print("Remove Pending Notification")
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["VaccinationReminder"])
            
            reminderStatus.text = "Reminder is off"
        }
    }
    
    // initial setup
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // request for notification, TODO: handle error, not allowed
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {allowed, error in
            
            
            })
        
        datePicker.backgroundColor = UIColor.white
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

