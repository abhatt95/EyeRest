//
//  ViewController.swift
//  Time2
//
//  Created by abhishek on 9/10/17.
//  Copyright © 2017 abhishek. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    //make instance from SoundControl
    var sc = SoundControl()
    var myTimer : Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var Display: UILabel!

    @IBOutlet weak var ControlButton: UIButton!
    var counter: Int = 20
    @IBAction func ControlButtonPressed(_ sender: UIButton) {
        if ControlButton.currentTitle == "Start" {
            sc.playAudio(play: "Relax1.mp4")
            setNotification(fore: 20)
            SetTimer()
        ControlButton.setTitle("Reset", for: .normal)
        }
        else
        {
            reset()
        ControlButton.setTitle("Start", for: .normal)
        }

        
        //ControlButton.currentTitle == "Start" ? ControlButton.setTitle("Reset", for: .normal) : ControlButton.setTitle("Start", for: .normal)
        
        
        
    }
    
    func setNotification (fore minutes: Double) {
        
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey:
            "Good Job! ", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey:
            "Feel Better ", arguments: nil)
        //content.sound = UNNotificationSound.default()
        print(content.title)
        print(content.body)
        // Deliver the notification in five seconds.
        //
        content.sound = UNNotificationSound(named:"alarm.caf" )
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: minutes,
                                                        repeats: false)
        
        
        let request = UNNotificationRequest(identifier: "TwentySecond", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        

    
    }
    func removeNotification () {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["TwentySecond"])
        //UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    func SetTimer () {
        myTimer = Timer.scheduledTimer(timeInterval: 1 ,
                                       target: self,
                                       selector: #selector(ViewController.update),
                                       userInfo: nil,
                                       repeats: true)

    }
    func update() {
        if(counter > 0) {
            Display.text = String(counter)
            print(Display.text!)
            counter = counter - 1
        }
        else{
        reset()
        }
    }
    func reset() {
        
        counter = 20
        Display.text = "20"
        sc.StopAudio()
        myTimer.invalidate()
        removeNotification()
        ControlButton.setTitle("Start", for: .normal)
        
    }
    func setNotificationsFromTimer(daysare : Dictionary< String , Any> ,from: String , to : String , every : Int)
    {
        // datecomp var datecopm = DateComponents()
        // repeating alert with date help https://makeapppie.com/2017/01/31/how-to-repeat-local-notifications/
       /* print("timer will be set from :", from ," to :", to)
        let mins = Double(every*60)
    let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Eye Exercise", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Time to rest your eyes", arguments: nil)
        content.categoryIdentifier = "rest.reminder.category"
        let trigger  = UNTimeIntervalNotificationTrigger(timeInterval: mins, repeats: true)
        
        content.sound = UNNotificationSound(named:"alarm.caf" )
        
        let request = UNNotificationRequest(identifier: "repeated", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
print("Previous Monday was on  ", get(direction: .Previous, "Monday"))
        print("Next Monday is on  ", get(direction: .Next, "Monday"))
*/
        print("from ",from," to ",to )
        var startHour,startMinute,endHour,endMinute : Int
        (startHour,startMinute) = getTimeFromString(input: from)
        (endHour,endMinute) = getTimeFromString(input: to)
        print(startHour, startMinute , endHour , endMinute)
        
        //
       let count =  noOfAlerts(startHour: startHour, startMinute: startMinute, endHour: endHour, endMinute: endMinute, every: every)
        print("No of loops required will be ",count)
        let dayscare2 = daysare as! [String: Bool]
        for (key,value) in dayscare2
        {
            switch key {
            case "Monday":
                if value
                {
                    print("Adding for ", key)
                    setAlertOnThatDayAtThatTime(dayid: 2 ,hour: startHour, minute: startMinute, number: count, every:every )
                }
            case "Tuesday":
                if value
                {
                    print("Adding for ", key)

                    setAlertOnThatDayAtThatTime(dayid: 3 ,hour: startHour, minute: startMinute, number: count, every:every )
                }
            case "Wednesday":
                if value
                {
                    print("Adding for ", key)

                    setAlertOnThatDayAtThatTime(dayid: 4 ,hour: startHour, minute: startMinute, number: count, every:every )
                }
            case "Thursday":
                if value
                {
                    print("Adding for ", key)

                    setAlertOnThatDayAtThatTime(dayid: 5 ,hour: startHour, minute: startMinute, number: count, every:every )
                }
            case "Friday":
                if value
                {
                    setAlertOnThatDayAtThatTime(dayid: 6 ,hour: startHour, minute: startMinute, number: count, every:every )
                }
            case "Saturday":
                if value
                {
                    print("Adding for ", key)

                    setAlertOnThatDayAtThatTime(dayid: 7 ,hour: startHour, minute: startMinute, number: count, every:every )
                }
            case "Sunday":
                if value
                {
                    print("Adding for ", key)

                    setAlertOnThatDayAtThatTime(dayid: 1 ,hour: startHour, minute: startMinute, number: count, every:every )
                }

            default:
                print("Day not found")
            }
        
        }
        //setAlertOnThatDayAtThatTime(hour: startHour, minute: startMinute, number: count, every:every )


    }
    func removeNotificationFromTimer()
    {
        print("All notifications are removed ")
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    // all functions for finding days date
    func getWeekDaysInEnglish() -> [String] {
        let calender = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        calender.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        return calender.weekdaySymbols
    }
    enum SearchDirection {
        case Next
        case Previous
        
        var CalenderOptions : NSCalendar.Options {
            switch self {
            case .Next:
                return .matchNextTime
            case .Previous:
                return [.searchBackwards, . matchNextTime]
           
            }
        }
    }
    func get(direction : SearchDirection, _ dayName: String, considerToday consider: Bool = false) -> NSDate {
        let weekdaysName = getWeekDaysInEnglish()
         assert(weekdaysName.contains(dayName),"weekday should be in the form  \(weekdaysName)")
        
        let nextWeekDayIndex = weekdaysName.index(of: dayName)! + 2
        let today  = NSDate()
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
       
        if  consider && calendar.component(.weekday, from: today as Date) == nextWeekDayIndex
            {
        
        return today
        }
        let nextDateComponent = NSDateComponents()
        nextDateComponent.weekday = nextWeekDayIndex
        let date = calendar.nextDate(after: today as Date, matching: nextDateComponent as DateComponents, options: direction.CalenderOptions)
        return date! as NSDate
        
        
    }
    
    //set alert on that day on that time parameter day:Date,  time:Date,  s_time: Double
    func setAlertOnThatDayAtThatTime(dayid : Int, hour : Int, minute : Int,  number : Int, every : Int )
    {
        let update = every
        var minuteOnwhichyouWantIt  = minute
        var hourONWhichYouWantIt = hour
        
        var dateComponents = DateComponents()
        dateComponents.hour = hourONWhichYouWantIt
        dateComponents.minute = minute
        
        //just for 1st one 
        print(index)
        let content2 = UNMutableNotificationContent()
        content2.title = NSString.localizedUserNotificationString(forKey: "Eye Exercise", arguments: nil)
        content2.body = NSString.localizedUserNotificationString(forKey: "Time to rest your eyes at 001", arguments: nil)
        content2.categoryIdentifier = "rest.reminder.category" + "001"
        
        let trigger2  = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true)
        
        content2.sound = UNNotificationSound(named:"alarm.caf" )
        
        let request2 = UNNotificationRequest(identifier: String(dayid) + "rest.reminder.category 001" , content: content2, trigger: trigger2)
        UNUserNotificationCenter.current().add(request2, withCompletionHandler: nil)
        // just for first one ends here

        for index in  stride(from: 0, to: number, by: 1)  {
            print(index)
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Eye Exercise", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Time to rest your eyes at "+String(index), arguments: nil)
        content.categoryIdentifier = "rest.reminder.category" + String(index)
        
            dateComponents.minute = minuteOnwhichyouWantIt

            print(" dateComponents.minute! + update ", dateComponents.minute! + update)
            if ( dateComponents.minute! + update ) <  60
            //if(minuteOnwhichyouWantIt + update) >= 60
            {
                
                dateComponents.hour = hourONWhichYouWantIt
                minuteOnwhichyouWantIt = minuteOnwhichyouWantIt + update
                dateComponents.minute = minuteOnwhichyouWantIt
                print(dayid , "setAlertOnThatDayAtThatTime Hour :", dateComponents.hour ?? 0," minutes :",dateComponents.minute ?? 0)

                         }
            else
            {
              //  print("I was here in 60")
                hourONWhichYouWantIt = hourONWhichYouWantIt + 1
                dateComponents.hour = hourONWhichYouWantIt
                minuteOnwhichyouWantIt = minuteOnwhichyouWantIt + update - 60
                dateComponents.minute = minuteOnwhichyouWantIt
                print(dayid ,"from setAlertOnThatDayAtThatTime if Hour :", dateComponents.hour ?? 0," minutes :",dateComponents.minute ?? 0)
                

            }
        dateComponents.weekday = dayid
        dateComponents.second = 0
        let trigger  = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true)
        
        content.sound = UNNotificationSound(named:"alarm.caf" )
        
        let request = UNNotificationRequest(identifier: String(dayid) + "rest.reminder.category" + String(index), content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        }
    }
    // get time from string in 24 hours format
    func getTimeFromString(input : String) ->(Int,Int) {
        if input.contains("AM")
        {
         
            let input2 = input.replacingOccurrences(of: "AM", with: "")
            let input3 = input2.trimmingCharacters(in: .whitespaces)
           let parts =  input3.components(separatedBy: ":")
            print("getTimeFromString hours :",parts[0]," minutes ",parts[1])
return (Int(parts[0])!,Int(parts[1])!)
        }
        
        let input2 = input.replacingOccurrences(of: "PM", with: "")
        let input3 = input2.trimmingCharacters(in: .whitespaces)
        let parts =  input3.components(separatedBy: ":")
        print("getTimeFromString hours :",(Int(parts[0])!+12)," minutes ",parts[1])
        return ((Int(parts[0])!+12),Int(parts[1])!)

        
        
    
    }
    func noOfAlerts(startHour:Int,startMinute:Int,endHour:Int,endMinute:Int,every:Int)-> Int{
        var val : Int = 0
        var startH = startHour
        var startM = startMinute
        while (startH <= endHour)  {
            if (startH >= endHour) && startM >= endMinute {break}
            print("current value of ",startH,startM)
            if (startM + every) >= 60
            {
                startH = startH + 1
            startM = startM + every - 60
                val+=1
            }
            else
            {
            startM = startM + every
                val+=1
            }

        }
        print("No of alerts is ", val)
        return val
        
    
    
    }


}

