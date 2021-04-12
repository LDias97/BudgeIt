import Foundation
import SwiftUI

let grey = Color(red: 240/255, green: 240/255, blue: 240/255)
let darkPurple = Color(red: 96/255, green: 96/255, blue: 235/255)
let lightPurple = Color(red: 177/255, green: 127/255, blue: 248/255)
let red = Color(red: 220/255, green: 104/255, blue: 101/255)
let green = Color(red: 87/255, green: 210/255, blue: 150/255)


enum MonthSelector : Int {
    case Jan
    case Feb
    case Mar
    case Apr
    case May
    case Jun
    case Jul
    case Aug
    case Sep
    case Oct
    case Nov
    case Dec
    
    static let abreviatedNames: [MonthSelector: String] = [
        .Jan: "Jan",
        .Feb: "Feb",
        .Mar: "Mar",
        .Apr: "Apr",
        .May: "May",
        .Jun: "Jun",
        .Jul: "Jul",
        .Aug: "Aug",
        .Sep: "Sep",
        .Oct: "Oct",
        .Nov: "Nov",
        .Dec: "Dec"
    ]
    
    static let fullNames: [MonthSelector: String] = [
        .Jan: "January",
        .Feb: "February",
        .Mar: "March",
        .Apr: "April",
        .May:  "May",
        .Jun: "June",
        .Jul: "July",
        .Aug: "August",
        .Sep: "September",
        .Oct: "October",
        .Nov: "November",
        .Dec: "December"
    ]
    
    var name: String {
        return MonthSelector.abreviatedNames[self]!
    }
    var fullName: String {
        return MonthSelector.fullNames[self]!
    }
}
