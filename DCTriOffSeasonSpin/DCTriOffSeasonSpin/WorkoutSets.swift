//
//  WorkoutSets.swift
//  DCTriOffSeasonSpin
//
//  Created by Yuchen Nie on 12/14/15.
//  Copyright © 2015 WeddingWire. All rights reserved.
//

import Foundation
import UIKit

class WorkoutSet {
    static let sharedInstance = WorkoutSet()
    var playlist = [Set]()
    init() {
        addInSet()
    }
    
    func addInSet() {
        //Warm up
        playlist.append(Set(time: "8:00", cad: "Any Cadence", zone: "Easy"))//0-8
        playlist.append(Set(time: "5:00", cad: "80-95 RPM", zone: "Zone 2 -> Zone 5"))//8-13
        playlist.append(Set(time: "2:00", cad: "Anything Cadence", zone: "Zone 2"))//13-15
        playlist.append(Set(time: "2:00", cad: "3 x 6 sec Accelerations", zone: "Zone 2"))//15-17
        playlist.append(Set(time: "3:00", cad: "Any Cadence", zone: "Easy"))//17-20
        
        //Set 1
        playlist.append(Set(time: "4:00", cad: "75 RPM", zone: "Low Zone 3"))
        playlist.append(Set(time: "4:00", cad: "Alternating legs", zone: "Zone 2"))
        playlist.append(Set(time: "4:00", cad: "75 RPM", zone: "Zone 3"))
        
        //Set 2
        playlist.append(Set(time: "4:00", cad: "80 RPM", zone: "High Zone 3"))
        playlist.append(Set(time: "4:00", cad: "Alternating legs", zone: "Zone 2"))
        playlist.append(Set(time: "4:00", cad: "80 RPM", zone: "Zone 3"))
        
        //Set3
        playlist.append(Set(time: "4:00", cad: "90 RPM", zone: "Threshold Low"))
        playlist.append(Set(time: "4:00", cad: "Alternating legs", zone: "Zone 2"))
        playlist.append(Set(time: "4:00", cad: "85 RPM", zone: "Zone 3"))
        
        //set4
        playlist.append(Set(time: "4:00", cad: "90 RPM", zone: "Threshold Medium"))
        playlist.append(Set(time: "4:00", cad: "Alternating legs", zone: "Zone 2"))
        playlist.append(Set(time: "4:00", cad: "90 RPM", zone: "Zone 3"))
        
        //set 5
        playlist.append(Set(time: "4:00", cad: "95 RPM", zone: "Threshold High"))
        playlist.append(Set(time: "4:00", cad: "Alternating legs", zone: "Zone 2"))
        playlist.append(Set(time: "4:00", cad: "90 RPM", zone: "Zone 3"))
        
        //Set 6
        playlist.append(Set(time: "4:00", cad: "95 RPM", zone: "Threshold High"))
        playlist.append(Set(time: "4:00", cad: "Alternating legs", zone: "Zone 2"))
        playlist.append(Set(time: "4:00", cad: "95 RPM", zone: "Zone 3"))
        
        playlist.append(Set(time: "10:00", cad: "Any Cadence", zone: "Easy/Break"))
        
        //Set 7
        playlist.append(Set(time: "6:00", cad: "70 RPM", zone: "Threshold"))
        
        //Set 8
        playlist.append(Set(time: "3:00", cad: "Easy", zone: "Recovery"))
        playlist.append(Set(time: "6:00", cad: "90 RPM", zone: "Threshold"))
        
        //Set 9
        playlist.append(Set(time: "1:45", cad: "90 RPM", zone: "Threshold"))//1
        playlist.append(Set(time: "0:15", cad: "100 RPM", zone: "Attack"))
        playlist.append(Set(time: "1:45", cad: "90 RPM", zone: "Threshold"))//2
        playlist.append(Set(time: "0:15", cad: "100 RPM", zone: "Attack"))
        playlist.append(Set(time: "1:45", cad: "90 RPM", zone: "Threshold"))//3
        playlist.append(Set(time: "0:15", cad: "100 RPM", zone: "Attack"))
        playlist.append(Set(time: "1:45", cad: "90 RPM", zone: "Threshold"))//4
        playlist.append(Set(time: "0:15", cad: "100 RPM", zone: "Attack"))
        playlist.append(Set(time: "1:45", cad: "90 RPM", zone: "Threshold"))//5
        playlist.append(Set(time: "0:15", cad: "100 RPM", zone: "Attack"))
        
        
        //Cooldown
        playlist.append(Set(time: "4:00", cad: "Easy", zone: "Cooldown!"))
    }
}


struct Set {
    let duration:NSTimeInterval
    let cadence:String
    let heartRate:String
    
    init(time:String, cad:String, zone: String){
        let timeComponents = time.componentsSeparatedByString(":")
        if let strMinutes = NSNumberFormatter().numberFromString(timeComponents[0]), strSeconds = NSNumberFormatter().numberFromString(timeComponents[1]){
            let minutes = Double(strMinutes) * 60
            let seconds = Double(strSeconds)
            duration = minutes + seconds
        } else {
            duration = 0
        }
        cadence = cad
        heartRate = zone
    }
}