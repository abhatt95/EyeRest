//
//  setTimings.swift
//  Time2
//
//  Created by abhishek on 9/17/17.
//  Copyright © 2017 abhishek. All rights reserved.
//

import Foundation
import  UIKit
import UserNotifications

class setTimings: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {
    
    /*
     
     All notifications will be set for days being selected by user from M - Su
     [use an array for above]
     For period between startField - endField
     [use var of same name]
     use interval from slider
     [currentValueOfInterval]
     
     set notifications on reminder is on [type bool]
     [remove them if false]
     give everything a default value 
     
     everytime any parametre changes save them permanantly in app 
     */
    //let CustomBlue = UIColor(red:16.0,green:98.0,blue:144.0,alpha:1.0)
let CustomBlue = UIColor.init(red: 22/255, green: 122/255, blue: 255/255, alpha: 1.0)
let CustomRed = UIColor.init(red: 243/255, green: 37/255, blue: 49/255, alpha: 1.0)
// declare global defaults
  //  let defaults: UserDefaults = UserDefaults.standard
// declare app domain to remove all keys 
    let appDomain = Bundle.main.bundleIdentifier!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setColorOfButton()
        OnOff.isOn = false
    //    DatePicker.isHidden = true
  
        
        // Do any additional setup after loading the view, typically from a nib.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(setTimings.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        if TS.checkIfSwitchAvailable()
        {
        
        print("iwas here to update switch")
            OnOff.isOn = TS.SwitchIs()
        }
if TS.checkIfDaysAvailable()
{
    print("yes i was here to checkIfDaysAvailable")
    isThisDayChosen = TS.getDays() as! [String : Bool]
    setColorOfButton()
        }
        if TS.checkIfDateIsAvailable()
        {
        (startField.text!,endField.text!) = TS.giveMeTheDates()
        }

    
        //seting days from user defaults
        
      /*  if let  day: Bool = defaults.bool(forKey: "RemainderStatus") {
        OnOff.isOn = day
        }
        
      */
        
  /*      if let days = defaults.dictionary(forKey: "days")
        {
        isThisDayChosen = days as! [String : Bool]
        }
    */
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        timePicker.removeFromSuperview() // if you want to remove time picker
        timePicker2.removeFromSuperview()
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    let timePicker = UIDatePicker()
    let timePicker2 = UIDatePicker()
    // 1 All days of week processing starts here
    
    var isThisDayChosen = ["Monday":true,
                           "Tuesday":true,
                           "Wednesday":true,
                           "Thursday":true,
                           "Friday":true,
                           "Saturday":false,
                           "Sunday":false]

    @IBOutlet weak var Monday: UIButton!
    @IBOutlet weak var Tuesday: UIButton!
    @IBOutlet weak var Wednesday: UIButton!
    @IBOutlet weak var Thursday: UIButton!
    @IBOutlet weak var Friday: UIButton!
    @IBOutlet weak var Saturday: UIButton!
    @IBOutlet weak var Sunday: UIButton!
    
   @IBAction func ChoseThisDay(_ sender: UIButton) {
    OnOff.isOn = false

        let day = sender.currentTitle
    switch day! {
    case "M":
       isThisDayChosen["Monday"] = isThisDayChosen["Monday"] == true  ? false : true
    case "T":
        isThisDayChosen["Tuesday"] = isThisDayChosen["Tuesday"] == true  ? false : true
    case "W":
        isThisDayChosen["Wednesday"] = isThisDayChosen["Wednesday"] == true  ? false : true
    case "Th":
        isThisDayChosen["Thursday"] = isThisDayChosen["Thursday"] == true  ? false : true
    case "F":
        isThisDayChosen["Friday"] = isThisDayChosen["Friday"] == true  ? false : true
    case "S":
        isThisDayChosen["Saturday"] = isThisDayChosen["Saturday"] == true  ? false : true
    case "Su":
        isThisDayChosen["Sunday"] = isThisDayChosen["Sunday"] == true  ? false : true
    default:
        print("nada")
        
    }
    setColorOfButton()
    }
    
    func setColorOfButton() {
        for (key,value) in isThisDayChosen {
        switch key {
        case "Monday":
            if value
            {
                Monday.setTitleColor(CustomRed, for: .normal)
            }
            else
            {
                Monday.setTitleColor(CustomBlue, for: .normal)
            }
            // 243 37 49
        case "Tuesday":
            if value
            {
                Tuesday.setTitleColor(CustomRed, for: .normal)
            }
            else
            {
                Tuesday.setTitleColor(CustomBlue, for: .normal)
            }

        case "Wednesday":
            if value
            {
                Wednesday.setTitleColor(CustomRed, for: .normal)
            }
            else
            {
                Wednesday.setTitleColor(CustomBlue, for: .normal)
            }

        case "Thursday":
            if value
            {
                Thursday.setTitleColor(CustomRed, for: .normal)
            }
            else
            {
                Thursday.setTitleColor(CustomBlue, for: .normal)
            }

        case "Friday":
            if value
            {
                Friday.setTitleColor(CustomRed, for: .normal)
            }
            else
            {
                Friday.setTitleColor(CustomBlue, for: .normal)
            }

        case "Saturday":
            if value
            {
                Saturday.setTitleColor(CustomRed, for: .normal)
            }
            else
            {
                Saturday.setTitleColor(CustomBlue, for: .normal)
            }

        case "Sunday":
            if value
            {
                Sunday.setTitleColor(CustomRed, for: .normal)
            }
            else
            {
                Sunday.setTitleColor(CustomBlue, for: .normal)
            }

        default:
            print("Non of the above")
        }
        }
    
    }
    
    
    // 1  All days of week processing ends here
    
    // 2 All Start and End Time processing below this

    @IBOutlet weak var startField: UITextField!
    
    @IBOutlet weak var endField: UITextField!

    
    //everything date picker 
    var datePicker : UIDatePicker!
    
    
    func pickUpDate(_ textField : UITextField){
        
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor.white
        self.datePicker.datePickerMode = UIDatePickerMode.time
        textField.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(setTimings.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(setTimings.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    
    func doneClick() {
        let dateFormatter1 = DateFormatter()
   // dateFormatter1.dateFormat = "hh:mm"
        dateFormatter1.dateStyle = .none
        dateFormatter1.timeStyle = .short
     //   print(" 1 ",datePicker.date)
        startField.text = String(describing: datePicker.date)
        startField.text = dateFormatter1.string(from: datePicker.date)
        startField.resignFirstResponder()
    }
    func cancelClick() {
        startField.resignFirstResponder()
    }
    
    // https://stackoverflow.com/questions/44346811/extracting-hours-and-minutes-from-uidatepicker
    @IBAction func StartTimeSetter(_ sender: UITextField) {
        OnOff.isOn = false
        self.pickUpDate(self.startField)

}
    
    
    //everything date picker for end time
    var datePicker2 : UIDatePicker!
    
    
    func pickUpDate2(_ textField : UITextField){
        
        // DatePicker
        self.datePicker2 = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker2.backgroundColor = UIColor.white
        self.datePicker2.datePickerMode = UIDatePickerMode.time
        textField.inputView = self.datePicker2
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
       toolBar.tintColor = CustomBlue
        // toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(setTimings.doneClick2))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(setTimings.cancelClick2))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    
    func doneClick2() {
        let dateFormatter2 = DateFormatter()
        // dateFormatter1.dateFormat = "hh:mm"
        dateFormatter2.dateStyle = .none
        dateFormatter2.timeStyle = .short
        //   print(" 1 ",datePicker.date)
        endField.text = String(describing: datePicker2.date)
        endField.text = dateFormatter2.string(from: datePicker2.date)
        endField.resignFirstResponder()
    }
    func cancelClick2() {
        endField.resignFirstResponder()
    }
    
    @IBAction func EndTimeTeller(_ sender: UITextField) {
        OnOff.isOn = false
        self.pickUpDate2(self.endField)
    }
    
    @IBOutlet weak var OnOff: UISwitch!
    func sendAlert(number:Int){
        var title : String
        var body : String
        switch number {
        case 0:
            title = "Time Error"
            body = "End time entered is before start time."
        case 1 :
            title = "Day Error"
            body = "Atleast one day has to be chosen."
        default:
            title = "Timepass"
            body = "Tum Time Pass Hai"
        }
        let alert = UIAlertController(title: title, message: body, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    
    }
    var date = Date()
    var date2 = Date()
    @IBAction func OnOffCalled(_ sender: UISwitch) {
        print("1",sender.isOn)
        if sender.isOn{
        OnOff.isOn = true
        }
        else{
        VC.removeNotificationFromTimer()
        OnOff.isOn = false
        }
        print("2")
        let dF = DateFormatter()
        dF.dateFormat = .none
        dF.timeStyle = .short
         date = dF.date(from: startField.text!)!
 date2 = dF.date(from: endField.text!)!
        if date > date2 {
            VC.removeNotificationFromTimer()

        OnOff.isOn = false
            //alert user 
sendAlert(number: 0)
    }
        var test = 0
        for (_,value) in isThisDayChosen {
            if value == true{
            test += 1
            }
        }
        if test == 0 {
            OnOff.isOn = false
            sendAlert(number: 1)
        }
        if OnOff.isOn{
        print("is on")
        //set all notifications
            setNotifications()
        }
        else
        {
            VC.removeNotificationFromTimer()

            print("is off")
            TS.saveSwitch(statusOfSwitch: OnOff.isOn)

        //remove all notifications
        }
        
    }
    var TS = TimingSaver()
    var VC = ViewController()
    func setNotifications() {
        if TS.checkIfDaysAvailable()
        {
        print("yes days are available")
        }
        else{
        print("no")
        }
        TS.save(days: isThisDayChosen)
        TS.saveSwitch(statusOfSwitch: OnOff.isOn)
        TS.saveStartDateAndEndDate(startDate: startField.text!, endDate: endField.text!)

        if TS.checkIfSwitchAvailable()
        {
            print("yes switch is available")
        }
        else{
            print("no")
        }
        if TS.checkIfDateIsAvailable()
        {
            print("yes start and end date is available")
        }
        else{
            print("no")
        }
        VC.setNotificationsFromTimer(daysare: isThisDayChosen, from: startField.text!, to: endField.text!, every: 20)
        /*
        if OnOff.isOn{
            //user defaults 
            print("3")
            // check if days is alreday set if yes than remove it and set again
            if defaults.dictionary(forKey: "days") != nil
            {
                for (key,value) in defaults.dictionary(forKey: "days")!
                {
                    print("\(key) = \(value)")
                    
                }

                UserDefaults.standard.removePersistentDomain(forName: appDomain)
              //  defaults.removeObject(forKey: "days")
                print("removed")

            }
            defaults.set(isThisDayChosen, forKey: "days")
            defaults.set(OnOff, forKey: "RemainderStatus")
          /*  for (key,value) in UserDefaults.standard.dictionaryRepresentation()
            {
            print("\(key) = \(value)")
            }
 */
            for (key,value) in defaults.dictionary(forKey: "days")!
            {
                print("\(key) = \(value)")

            }
            
                    print(startField.text!)
        print(endField.text!)
            print("4")
        }
    */
    }
}
