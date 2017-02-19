//
//  ViewController.swift
//  Notification
//
//  Created by Kim Jasper Mui on 2/10/17.
//  Copyright © 2017 Kim Jasper Mui. All rights reserved.
//

import UIKit
import UserNotifications


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    // figure out how to reset view when entering from background
    
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var reminderStatus: UILabel!
    
    @IBOutlet weak var durationUnit: UITextField!
    @IBOutlet weak var durationChoices: UIPickerView!
    @IBOutlet weak var durationValue: UITextField!
    
    var notificationContent = UNMutableNotificationContent()

    var durationUnits = ["Days", "Weeks", "Months"]
    
    let SEC_IN_A_DAY : Double = 24 * 60 * 60
    let SEC_IN_A_WEEK : Double = 24 * 60 * 60 * 7
    let SEC_IN_A_MONTH : Double = 24 * 60 * 60 * 30

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
            
            let unit : String = durationUnit.text!
            let value : Double = Double(durationValue.text!)!

            switch durationUnits.index(of: unit)! {
                
                case 0:
                    adjustedDate -= SEC_IN_A_DAY * value
                
                case 1:
                    adjustedDate -= SEC_IN_A_WEEK * value
                
                case 2:
                    adjustedDate -= SEC_IN_A_MONTH * value
                
                default:
                    print("Error! This is not one of the units!")
            }
            
            print(adjustedDate)
            
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
    
    // this will specify the number of columns to show in the duration picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1;
    }
    
    // this will specify the number of elements in the picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return durationUnits.count
    }
    
    // this will match the corresponding elements in the arrays
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return durationUnits[row]
    }
    
    // this will hide the picker after selection and update the text field
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        durationUnit.text = durationUnits[row]
        durationChoices.isHidden = true
        
    }
    
    // no keyboard or cursor for user, this will show the picker when text field has been clicked
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        reminderStatus.text = "Reminder is off"
        notificationSwitch.setOn(false, animated: true)
        
        if textField == durationUnit {
            
            if !durationChoices.isHidden {
                
                durationChoices.isHidden = true
            }
            
            else {
            
                durationChoices.isHidden = false
            }
            
            return false
        }
        
        else {
            
            return true
        }
    }
    
    // reset textfield if necessary
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
        
        // set value to 0 if nothing has entered
        if durationValue.text == "" {
            
            durationValue.text = "0"
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
        datePicker.layer.cornerRadius = 10
        datePicker.layer.masksToBounds = true
        datePicker.minimumDate = Date.init()
    
        durationChoices.layer.cornerRadius = 10
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

