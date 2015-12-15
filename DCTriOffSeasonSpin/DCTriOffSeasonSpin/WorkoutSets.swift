//
//  WorkoutSets.swift
//  DCTriOffSeasonSpin
//
//  Created by Yuchen Nie on 12/14/15.
//  Copyright © 2015 WeddingWire. All rights reserved.
//

import Foundation

enum HeartRateZone {
    case Z1
    case Z2
    case Z3
    case Z4
    case Z5
}

struct WorkoutSets {
    let duration:NSDate
    let cadence:Int
    let heartRate:HeartRateZone
    
    init(time:NSDate, cad:Int, zone: HeartRateZone){
        duration = time
        cadence = cad
        heartRate = zone
    }
}