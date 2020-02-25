//
//  mDefaults.swift
//  Medico
//
//  Created by Lallu Sukendh on 20/04/18.
//  Copyright © 2018 g10solution. All rights reserved.
//

import Foundation
import UIKit


public class mDefaults {
//    imageview = UIImageView(image: #imageLiteral(resourceName: "medico_logo"))
//    navigationItem.titleView = imageview
//    let tapGestureRecognizer = UITapGestureRecognizer(target: ViewController(), action: #selector(imageTapped(tapGestureRecognizer:)))
//    imageview.addGestureRecognizer(tapGestureRecognizer)
//    imageview.isUserInteractionEnabled = true
    
    static let shareInstance = mDefaults()
    
 
    class func getTImezone (date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy HH:mm:ss z"
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        
        let dateString = dateFormatter.string(from: Date())
        let todayDate = dateFormatter.date(from: dateString)!
        print(dateString)
        print(todayDate)
        return dateString
    }
    
    class func covertDateToStringInWebserviceFormat (date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        return result
    }
    class func covertDateToStringInWebserviceFormatter (date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.string(from: date)
        return result
    }
    
    class func covertStringToDateInWebserviceFormat (dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "UTC")
        guard let result = formatter.date(from: dateString) else { return Date()}
        return result
    }
    class func covertStringToDateInWebserviceFormat1 (dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yy"
        formatter.timeZone = TimeZone(identifier: "UTC")
        guard let result = formatter.date(from: dateString) else { return Date()}
        return result
    }
    
    class func covertStringToDateInWebserviceFormat2 (dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        guard let result = formatter.date(from: dateString) else { return Date()}
        return result
    }
    class func covertDateToStringInDisplayFormat1 (date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        return result
    }
    class func covertDateToStringInDisplayFormat (date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        let result = formatter.string(from: date)
        return result
    }
    
    class func covertStringToDateInDisplayFormat (dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.timeZone = TimeZone(identifier: "UTC")
        guard let result = formatter.date(from: dateString) else { fatalError("Error: Mismatched date format.")}
        return result
    }
    
    class func getWebserviceDateInDisplayFormat(dateString: String) -> String {
        let date = covertStringToDateInWebserviceFormat(dateString: dateString)
        let displayDate = covertDateToStringInDisplayFormat(date: date)
        return displayDate
    }
    
    class func getDateComponentsFromDate(date: Date) -> DateComponents {
        let component = Calendar.current.dateComponents([.year,.day,.month,.weekday, .calendar], from: date)
        return component
    }
    
    class func convertTimeStringToDate(timeString: String) -> Date {
        let formatter = DateFormatter()
        if timeString == "" {
            formatter.dateFormat = ""
          let  dateTime = formatter.date(from: timeString)
            return dateTime!
        }else {
            formatter.dateFormat = "HH:mm:ss"
            let dateTime = formatter.date(from: timeString)
            return (dateTime)!
        }
        
        
    }
    
    class func convertDateTimeToString (timeDate: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let dateTime = formatter.string(from: timeDate)
        return dateTime
    }
    class func convertDateTimeToString1 (timeDate: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let dateTime = formatter.string(from: timeDate)
        return dateTime
    }
    
    class func convertDateToDisplayTimeStringIn24hrs (timeDate: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let dateTime = formatter.string(from: timeDate)
        return dateTime
    }
    
    class func getDayFromStringDate(dateString: String) -> String {
        let inDate = mDefaults.covertStringToDateInWebserviceFormat(dateString: dateString)
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.day, from: inDate)
        return String(weekDay)
    }
    
    class func isValidEmail(email:String) -> Bool {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = email as NSString
            let results = regex.matches(in: email, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    class func convertTimeStringInDisplayFormat(timeString: String) -> String {
        let timeDate = mDefaults.convertTimeStringToDate(timeString: timeString)
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
       let dateTime = formatter.string(from: timeDate)
       return dateTime
    }
    
    class func convertDisplayTimeStringInWebserviceFormat(timeString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let dateTime = formatter.date(from: timeString)
        
        let dformatter = DateFormatter()
        dformatter.dateFormat = "HH:mm:ss"
        let time = dformatter.string(from: dateTime!)
        return time
    }
    
    class func getWeekDayFromDate(date: Date) -> String {
        let component = Calendar.current.dateComponents([.year,.day,.month,.weekday], from: date)
        switch component.weekday! {
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tue"
        case 4:
            return "Wed"
        case 5:
            return "Thu"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            print("Error fetching days")
            return "Day"
        }
    }
    
    class func getYearArrayFromDate(date:Date) -> [String]{
        let calendar = Calendar.current
        var year = calendar.component(.year, from: date)
        var yearArray: [String] = []
        yearArray.append(String(year))
        for _ in 1...20{
            year = year+1
            yearArray.append(String(year))
        }
        return yearArray
    }
    
    class func getPreviousYearArrayFromDate(date:Date) -> [String]{
        let calendar = Calendar.current
        var year = calendar.component(.year, from: date)
        var yearArray: [String] = []
        yearArray.append(String(year))
        for _ in 1...68{
            year = year-1
            yearArray.append(String(year))
        }
        return yearArray
    }
    
    class func getMonthNameFromMonthValue(monthValue: String) -> String {
        let month = Int(monthValue)
        switch month {
        case 1?:
            return "Jan"
        case 2?:
            return "Feb"
        case 3?:
            return "Mar"
        case 4?:
            return "Apr"
        case 5?:
            return "May"
        case 6?:
            return "Jun"
        case 7?:
            return "Jul"
        case 8?:
            return "Aug"
        case 9?:
            return "Sep"
        case 10?:
            return "Oct"
        case 11?:
            return "Nov"
        case 12?:
            return "Dec"
        default:
            print("missing month")
            return ""
        }
    }
}
