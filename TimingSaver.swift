//
//  TimingSaver.swift
//  Time2
//
//  Created by abhishek on 9/19/17.
//  Copyright © 2017 abhishek. All rights reserved.
//

import UIKit

class TimingSaver: UIViewController {

    // everything here is for vaing USERDEFAULTS 
   
    
let defaults : UserDefaults = UserDefaults.standard
    
  //functions for days
    func save(days: Dictionary< String, Any>) {
        defaults.set(days, forKey: "days")
        defaults.synchronize()

        for (key,value) in defaults.dictionary(forKey: "days")!
        {
            print("\(key) = \(value)")
            
        }
    
    }
    
    func checkIfDaysAvailable() -> Bool {
    if (defaults.dictionary(forKey: "days") != nil)
    
    {
        return true
        
        }
    
        return false
    }
    
    func getDays() -> Dictionary<String, Any>  {
        return defaults.dictionary(forKey: "days")!
    }
    
    // functions for switch 
    func saveSwitch(statusOfSwitch: Bool) {
        defaults.set(statusOfSwitch,forKey: "statusOfSwitch")
        defaults.synchronize()
    }
    
    func checkIfSwitchAvailable() -> Bool {
    if defaults.bool(forKey: "statusOfSwitch")
    {
        return true
        }
        return false
        }
    func SwitchIs() -> Bool {
    
        print(defaults.bool(forKey: "statusOfSwitch"))
        return defaults.bool(forKey: "statusOfSwitch")
    
    }
    // function for start and end timings 
    func saveStartDateAndEndDate(startDate: String,endDate: String){
    defaults.set(startDate, forKey: "startDate")
        defaults.set(endDate, forKey: "endDate")
        defaults.synchronize()
        print("date saved is ", startDate,endDate)
        
    }
    func checkIfDateIsAvailable()->Bool{
    if (defaults.string(forKey: "startDate") != nil && defaults.string(forKey: "endDate") != nil )
    {return true
        }
        return false
        
    }
    func giveMeTheDates() -> (String,String) {
        print("give me the dates was called ")
        return (defaults.string(forKey: "startDate")! ,defaults.string(forKey: "endDate")!)
    }
    
    
}
