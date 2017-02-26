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
    
    // screen specification
    let SCREEN_SIZE: CGRect = UIScreen.main.bounds

    let ORIGIN: CGPoint = CGPoint(x: 0, y: 0)
    
    let CORNER_RADIUS: Int = 10
    let CHOICES_ALPHA: CGFloat = CGFloat(0.9)
    
    let HALF: Int = 2
    let MAX_DAYS: Int = 365
    let MAX_WEEKS: Int = 52
    let MAX_MONTHS: Int = 12
    let FULL_MINUTE: Double = 60
    
    // offsets
    let TOP_OFFSET: Int = 60
    let DATE_OFFSET: Int = 40
    let PICKER_OFFSET: Int = 90
    let DURATION_LABEL_OFFSET: Int = 85
    let REMINDER_LABEL_OFFSET: Int = 40
    let DURATION_VALUE_OFFSET_X: Int = 40
    let DURATION_CHOICES_OFFSET: Int = 85
    let DURATION_VALUE_CHOICES_OFFSET: Int = 85
    let B_OFFSET: Int = 60
    
    // title specification
    let TITLE_FONTSIZE: CGFloat = CGFloat(30)
    let BODY_FONTSIZE: CGFloat = CGFloat(25)
    let TEXT_FONTSIZE: CGFloat = CGFloat(15)
    let FONT = "Arial"
    
    // vaccination date title
    let TITLE_SIZE: CGSize = CGSize(width: 230, height: 40)
    var vTitle: UILabel! = nil
    var bTitle: UILabel! = nil
    
    // vaccination date text
    let TEXT_SIZE: CGSize = CGSize(width: 150, height: 30)
    var vText: UITextField! = nil
    var bText: UITextField! = nil
    
    // vaccination date picker
    let PICKER_SIZE: CGSize = CGSize(width: 320, height: 115)
    var vPicker: UIDatePicker! = nil
    var bPicker: UIDatePicker! = nil

    // vaccination date duration text
    let DURATION_LABEL_SIZE: CGSize = CGSize(width: 140, height: 20)
    var vDurationLabel: UILabel! = nil
    var bDurationLabel: UILabel! = nil
    
    // vaccination date reminder text
    let REMINDER_LABEL_SIZE: CGSize = CGSize(width: 180, height: 20)
    var vReminderLabel: UILabel! = nil
    var bReminderLabel: UILabel! = nil
    
    // vaccination date duration unit
    let DURATION_UNIT_SIZE: CGSize = CGSize(width: 70, height: 30)
    var vDurationUnit: UITextField! = nil
    var bDurationUnit: UITextField! = nil
    
    // vaccination date duration value
    let DURATION_VALUE_SIZE: CGSize = CGSize(width: 40, height: 30)
    var vDurationValue: UITextField! = nil
    var bDurationValue: UITextField! = nil
    
    // vaccination date duration choices
    let DURATION_CHOICES_SIZE: CGSize = CGSize(width: 130, height: 125)
    var vDurationChoices: UIPickerView! = nil
    var bDurationChoices: UIPickerView! = nil
    
    // vaccination date duration choices
    let DURATION_VALUE_CHOICES_SIZE: CGSize = CGSize(width: 130, height: 125)
    var vDurationValueChoices:UIPickerView! = nil
    var bDurationValueChoices:UIPickerView! = nil
    
    // vaccination date switch
    let SWITCH_SIZE: CGSize = CGSize(width: 51, height: 31)
    var vSwitch: UISwitch! = nil
    var bSwitch: UISwitch! = nil
    
    var durationUnits = ["Days", "Weeks", "Months"]
    var vDurationValues: [Int] = [0]
    var bDurationValues: [Int] = [0]
    
    
    let SEC_IN_A_DAY : Double = 24 * 60 * 60
    let SEC_IN_A_WEEK : Double = 24 * 60 * 60 * 7
    let SEC_IN_A_MONTH : Double = 24 * 60 * 60 * 30
    
    func resetReminder() {
        
        vReminderLabel.text = "Reminder is off"
        vSwitch.setOn(false, animated: true)
    }
    
    
    // this is an event user scrolls to select a time
    @IBAction func timeChanged(sender: UIDatePicker) {
    
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.long
        vText.text = formatter.string(from: vPicker.date)
        
        vDurationValue.text = "0"
        
        resetReminder()
    }
    
    func setNotification(picker: UIDatePicker, value: UITextField, unit: UITextField, label: UILabel, notificationString: String) {
        
        let notificationContent = UNMutableNotificationContent()
        
        print("Switch On")
        label.text = "Reminder is on"
        
        // obtain the date and time user chooses
        var adjustedDate = picker.date
        
        // 0 out the second
        adjustedDate -= adjustedDate.timeIntervalSince1970.truncatingRemainder(dividingBy: FULL_MINUTE)
        
        let unitString: String = unit.text!
        let value: Double = Double(value.text!)!
        
        switch durationUnits.index(of: unitString)! {
            
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
        
        // notification's content
        notificationContent.title = "\(notificationString) Reminder"
        notificationContent.body = "\(notificationString) is in \(Int(value)) \(unitString)!"
        notificationContent.badge = 1
        notificationContent.sound = UNNotificationSound.default()
        notificationContent.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
        
        // set the notification time
        var notificationTime = DateComponents()
        notificationTime.year = picker.calendar.component(Calendar.Component.year, from: adjustedDate)
        notificationTime.month = picker.calendar.component(Calendar.Component.month, from: adjustedDate)
        notificationTime.day = picker.calendar.component(Calendar.Component.day, from: adjustedDate)
        notificationTime.hour = picker.calendar.component(Calendar.Component.hour, from: adjustedDate)
        notificationTime.minute = picker.calendar.component(Calendar.Component.minute, from: adjustedDate)
        notificationTime.second = picker.calendar.component(Calendar.Component.second, from: adjustedDate)
        
        // send notification at this time
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: false)
        
        // requesting notification
        let notificationRequest = UNNotificationRequest(identifier: "\(notificationString) Reminder", content:notificationContent, trigger: notificationTrigger)
        
        // the notification center for displaying the notification
        UNUserNotificationCenter.current().add(notificationRequest) { (error : Error?) in
            
            if let theError = error {
                
                print(theError.localizedDescription)
            }
        }
    }
    
    // this is an event when the switch changes state
    @IBAction func switchChanged(sender: UISwitch) {
        
        // vaccination date switch is on
        if sender == vSwitch {
            
            if vSwitch.isOn {
            
                setNotification(picker: vPicker, value: vDurationValue, unit: vDurationUnit, label: vReminderLabel, notificationString: "Vaccination Date")
            }
        
            // switch is off, remove the reminder if any
            else {
                
                print("Remove Pending Notification")
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Vaccination Date Reminder"])
                
                vReminderLabel.text = "Reminder is off"
            }
        }
    }
    
    // this will show/hide the choices
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == vText {
            
            if !vPicker.isHidden {
                
                vPicker.isHidden = true
                
                return false
            }
                
            else {
                
                vPicker.isHidden = false
                
                return false
            }
        }
        
        else if textField == vDurationUnit {
            
            if !vDurationChoices.isHidden {
                
                vDurationChoices.isHidden = true
                
                return false
            }
            
            else {
                
                vDurationChoices.isHidden = false
                
                return false
            }
        }
        
        else if textField == vDurationValue {
            
            if !vDurationValueChoices.isHidden {
                
                vDurationValueChoices.isHidden = true
                
                return false
            }
            
            else {
                
                // current, picker, and interval time in second
                let currentDate: Date = Date.init()
                let currentTime: TimeInterval = currentDate.timeIntervalSince1970 - currentDate.timeIntervalSince1970.truncatingRemainder(dividingBy: FULL_MINUTE)
                let pickerTime: TimeInterval = vPicker.date.timeIntervalSince1970
                let difference: Float = Float(pickerTime - currentTime)
                
                // the max value
                var value: Int = 0

                // clear up the array
                vDurationValues.removeAll()

                // calculate the max values
                if vDurationUnit.text == "Days" {
                    
                    value = Int(difference / Float(SEC_IN_A_DAY))
                }
                    
                else if vDurationUnit.text == "Weeks" {
                    
                    value = Int(difference / Float(SEC_IN_A_WEEK))
                }
                    
                else if vDurationUnit.text == "Months" {
                    
                    value = Int(difference / Float(SEC_IN_A_MONTH))
                }
                
                var i: Int = 0
                
                // get all valid selections
                while i <= value {

                    vDurationValues.append(i)
                    i += 1
                }

                vDurationValueChoices.reloadAllComponents()
                
                vDurationValueChoices.isHidden = false
                
                return false
            }
        }
        
        return false
    }
    
    // this will specify the number of columns to show in the duration picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1;
    }
    
    // this will specify the number of elements in the picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == vDurationChoices {
            
            return durationUnits.count
        }
        
        else if pickerView == vDurationValueChoices {
            
            return vDurationValues.count
        }

        return 0
    }
    
    // this will match the corresponding elements in the arrays
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == vDurationChoices {
            
        
            return durationUnits[row]
        }
        
        else if pickerView == vDurationValueChoices {
            
            return String(vDurationValues[row])
        }
        
        return durationUnits[row]
    }
    
    // this will hide the picker after selection and update the text field
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        resetReminder()
        
        if pickerView == vDurationChoices {
            
            vDurationUnit.text = durationUnits[row]
            vDurationChoices.isHidden = true
        }
        
        else if pickerView == vDurationValueChoices {
            
            vDurationValue.text = String(vDurationValues[row])
            vDurationValueChoices.isHidden = true
        }
    }

    // initial setup
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // request for notification, TODO: handle error, not allowed
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {allowed, error in
            
            
            })
        
        // configure vaccination date title
        vTitle = UILabel(frame: CGRect(origin: ORIGIN, size: TITLE_SIZE))
        vTitle.text = "Vaccination Date"
        vTitle.font = UIFont(name: FONT, size: TITLE_FONTSIZE)
        vTitle.center = CGPoint(x: Int(SCREEN_SIZE.width / CGFloat(HALF)), y: TOP_OFFSET)
        vTitle.textAlignment = NSTextAlignment.center
        self.view.addSubview(vTitle)

        // configure vaccination date text
        vText = UITextField(frame: CGRect(origin: ORIGIN, size: TEXT_SIZE))
        vText.center = CGPoint(x: Int(vTitle.center.x), y: Int(vTitle.center.y) + DATE_OFFSET)
        vText.backgroundColor = UIColor.white
        vText.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        vText.delegate = self
        vText.textAlignment = NSTextAlignment.center
        vText.font = UIFont(name: "Arial", size: TEXT_FONTSIZE)
        self.view.addSubview(vText)
        
        // configure vaccination date picker
        vPicker = UIDatePicker(frame: CGRect(origin: ORIGIN, size: PICKER_SIZE))
        vPicker.center = CGPoint(x: Int(vText.center.x), y: Int(vText.center.y) + PICKER_OFFSET)
        vPicker.backgroundColor = UIColor.white
        let currentDate = Date.init()
        vPicker.minimumDate = Date(timeIntervalSince1970: currentDate.timeIntervalSince1970 - currentDate.timeIntervalSince1970.truncatingRemainder(dividingBy: FULL_MINUTE))
        vPicker.layer.masksToBounds = true
        vPicker.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        vPicker.addTarget(self, action: #selector(self.timeChanged(sender:)), for: UIControlEvents.valueChanged)
        vPicker.isHidden = true
        self.view.addSubview(vPicker)
        
        // configure vaccination duration text
        vDurationLabel = UILabel(frame: CGRect(origin: ORIGIN, size: DURATION_LABEL_SIZE))
        vDurationLabel.text = "Notification:"
        vDurationLabel.font = UIFont(name: FONT, size: BODY_FONTSIZE)
        vDurationLabel.center = CGPoint(x: Int(vPicker.center.x - (vPicker.frame.width / CGFloat(HALF))) + Int(DURATION_LABEL_SIZE.width / CGFloat(HALF)), y: Int(vPicker.center.y) + DURATION_LABEL_OFFSET)
        vDurationLabel.textAlignment = NSTextAlignment.left
        self.view.addSubview(vDurationLabel)
        
        // configure vaccination reminder text
        vReminderLabel = UILabel(frame: CGRect(origin: ORIGIN, size: REMINDER_LABEL_SIZE))
        //TODO: check switch here
        vReminderLabel.text = "Reminder is off:"
        vReminderLabel.font = UIFont(name: FONT, size: BODY_FONTSIZE)
        vReminderLabel.center = CGPoint(x: Int(vPicker.center.x - (vPicker.frame.width / CGFloat(HALF))) + Int(REMINDER_LABEL_SIZE.width / CGFloat(HALF)), y: Int(vDurationLabel.center.y) + REMINDER_LABEL_OFFSET)
        vReminderLabel.textAlignment = NSTextAlignment.left
        self.view.addSubview(vReminderLabel)
        
        // configure vaccination date duration unit
        vDurationUnit = UITextField(frame: CGRect(origin: ORIGIN, size: DURATION_UNIT_SIZE))
        vDurationUnit.center = CGPoint(x: Int(vPicker.center.x) + Int(vPicker.frame.width / CGFloat(HALF)) - Int(vDurationUnit.center.x), y: Int(vDurationLabel.center.y))
        vDurationUnit.text = "Days"
        vDurationUnit.backgroundColor = UIColor.white
        vDurationUnit.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        vDurationUnit.delegate = self
        vDurationUnit.textAlignment = NSTextAlignment.center
        vDurationUnit.font = UIFont(name: "Arial", size: TEXT_FONTSIZE)
        self.view.addSubview(vDurationUnit)
        
        // configure vaccination date duration value
        vDurationValue = UITextField(frame: CGRect(origin: ORIGIN, size: DURATION_VALUE_SIZE))
        vDurationValue.center = CGPoint(x: Int(vDurationUnit.center.x - vDurationUnit.frame.width / CGFloat(HALF)) - DURATION_VALUE_OFFSET_X, y: Int(vDurationUnit.center.y))
        vDurationValue.text = "0"
        vDurationValue.backgroundColor = UIColor.white
        vDurationValue.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        vDurationValue.delegate = self
        vDurationValue.textAlignment = NSTextAlignment.center
        vDurationValue.font = UIFont(name: "Arial", size: TEXT_FONTSIZE)
        self.view.addSubview(vDurationValue)
        
        // configure vaccination date switch
        vSwitch = UISwitch(frame: CGRect(origin: ORIGIN, size: SWITCH_SIZE))
        vSwitch.center = CGPoint(x: vDurationUnit.center.x, y: vReminderLabel.center.y)
        vSwitch.addTarget(self, action: #selector(self.switchChanged(sender:)), for: UIControlEvents.valueChanged)
        self.view.addSubview(vSwitch)
        
        // configure vaccination date duration choices
        vDurationChoices = UIPickerView(frame: CGRect(origin: ORIGIN, size: DURATION_CHOICES_SIZE))
        vDurationChoices.center = CGPoint(x: Int(vDurationUnit.center.x + vDurationUnit.frame.width / CGFloat(HALF)) - Int(vDurationChoices.frame.width / CGFloat(HALF)), y: Int(vDurationUnit.center.y) + DURATION_CHOICES_OFFSET)
        vDurationChoices.backgroundColor = UIColor.white
        vDurationChoices.layer.masksToBounds = true
        vDurationChoices.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        vDurationChoices.alpha = CHOICES_ALPHA
        vDurationChoices.isHidden = true
        vDurationChoices.delegate = self
        self.view.addSubview(vDurationChoices)
        
        // configure vaccination date duration choices
        vDurationValueChoices = UIPickerView(frame: CGRect(origin: ORIGIN, size: DURATION_VALUE_CHOICES_SIZE))
        vDurationValueChoices.center = CGPoint(x: Int(vDurationValue.center.x - vDurationValue.frame.width / CGFloat(HALF)) + Int(vDurationValueChoices.frame.width / CGFloat(HALF)), y: Int(vDurationValue.center.y) + DURATION_VALUE_CHOICES_OFFSET)
        vDurationValueChoices.backgroundColor = UIColor.white
        vDurationValueChoices.layer.masksToBounds = true
        vDurationValueChoices.layer.cornerRadius = CGFloat(CORNER_RADIUS)
        vDurationValueChoices.alpha = CHOICES_ALPHA
        vDurationValueChoices.isHidden = true
        vDurationValueChoices.delegate = self
        self.view.addSubview(vDurationValueChoices)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

