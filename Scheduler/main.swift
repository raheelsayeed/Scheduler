//
//  main.swift
//  Scheduler
//
//  Created by Raheel Sayeed on 4/30/18.
//  Copyright © 2018 Boston Children's Hospital. All rights reserved.
//

import Foundation

public func makeDate(_ year: Int, _ month: Int, _ day: Int) -> Date {
	let calendar = Calendar(identifier: .gregorian)
	// calendar.timeZone = TimeZone(secondsFromGMT: 0)!
	let components = DateComponents(year: year, month: month, day: day)
	return calendar.date(from: components)!
}

let start = makeDate(2018, 3, 30)
let end = makeDate(2018, 5, 30)

let p = PeriodBound(start, end)

print(p)

let f = Frequency(value: 1, unit: "wk")
//print(f)


let s = Slot(period: p)
//print(s)


let sc = Schedule(period: p, freq: f)
for slot in sc.slots! {
	
	print("===")
	print("===")
	print(slot.period.start)
	print(slot.period.end)
	print(slot.current)
	
}


print("===")
print(sc.currentSlot)

print("===")
print(sc.nextSlot)


print("===")
print(sc.previousSlot)
print(sc.instant)




let si = Schedule(dueDate: Date())

print(si)
print(si.instant)

