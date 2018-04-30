//
//  Schedule.swift
//  Scheduler
//
//  Created by Raheel Sayeed on 4/30/18.
//  Copyright © 2018 Boston Children's Hospital. All rights reserved.
//

import Foundation

var str = "Hello, playground"

public enum SlotStatus : String {
    case due = "due"
    case upcoming = "upcoming"
    case missed   = "missed"
    case completedAllSessions = "completed"
    case unknown  = "unkown"
    
}


public struct PeriodBound : Equatable {
    
    let start   :   Date
    let end     :   Date
    let calender = PROCalender.shared.calender
    
    public static func == (lhs: PeriodBound, rhs: PeriodBound) -> Bool {
        return (lhs.start == rhs.start) && (lhs.end == rhs.end)
    }
    
    public static func > (lhs: PeriodBound, rhs: PeriodBound) -> Bool {
        return (lhs.start > rhs.end)
    }
    
    func contains(_ date:Date) -> Bool {
        
        let startDateOrder = calender.compare(date, to: start, toGranularity: .day)
        let endDateOrder = calender.compare(date, to: end, toGranularity: .day)
        
        let validStartDate = (startDateOrder == .orderedDescending) || (startDateOrder == .orderedSame)
        let validEndDate = endDateOrder == .orderedAscending || endDateOrder == .orderedSame
        
        
        print("\(validStartDate) || \(validEndDate)")
        
        return validStartDate && validEndDate
    }
    
    init(_ start: Date, _ end: Date) {
        self.start = start
        self.end   = end
    }
    
    init(duration: UInt64, from date: Date) {
        // calculate duration from date: Date
        // based on number o
        self.init(Date(), Date())
    }
}



public struct Frequency {
    let value   : Int
    let unit    : String
    // convert to granular period (F)
    
}




public struct Slot {
    
    let period : PeriodBound
    let status : SlotStatus = .unknown
    var current: Bool = false
    
    init(period: PeriodBound) {
        self.period = period
    }
    
}


public struct Schedule {
    
    
    /// Today's date
    let now = Date()
    
    /// Calculated or set value
    let period : PeriodBound?
    
    /// Slots available for PRO Measurement
    let slots : [Slot]?
    
    
    /// Frequency of a repeating measurement
    let frequency: Frequency?
    
    /// Current status of the current slot
    var currentStatus : SlotStatus? {
        get { return currentSlot?.status }
    }
    
    /// Current slot, based on `now`: today's date
    var currentSlot : Slot? {
        get {
            if let slots = slots { return slots.last }
            return nil
        }
        set {
            currentSlot = slots?.last
        }
    }
    
    
    /// Measurement is instant if no repeating schedule available
    var instant = false
    
    
    init(period: PeriodBound, freq: Frequency) {
        self.instant = false
        self.period = period
        self.frequency = freq
        self.slots = nil
        
        
    }
    
    private func configureSlots() {
        
        var  periodComponents : DateComponents {
            get {
                var pComponents = DateComponents()
                pComponents.day = (frequency!.value - 1)
                return pComponents
            }
        }
        
        
    }
    
    
    
    
    
    
}

















class PROCalender {
    
    static var shared = PROCalender()
    
    let calender : Calendar
    init() {
        let utc = TimeZone(abbreviation: "UTC")!
        var _calender = Calendar.current
        _calender.timeZone = utc
        //        let et = TimeZone.current
        //        _calender.timeZone = et
        calender = _calender
    }
}


extension Date {
    
    private static let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM dd, yyyy"
        formatter.calendar = PROCalender.shared.calender
        return formatter
    }()
    
    public var shortDate : String {
        return Date.dateFormat.string(from: self)
    }
}


