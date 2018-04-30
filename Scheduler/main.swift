//
//  main.swift
//  Scheduler
//
//  Created by Raheel Sayeed on 4/30/18.
//  Copyright © 2018 Boston Children's Hospital. All rights reserved.
//

import Foundation

let p = PeriodBound(Date(), Date())

print(p)

let f = Frequency(value: 1, unit: "w")
print(f)


let s = Slot(period: p)
print(s)


let sc = Schedule(period: p, freq: f)
print(sc)
