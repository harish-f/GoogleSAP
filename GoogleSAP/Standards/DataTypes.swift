//
//  DataTypes.swift
//  GoogleSAP
//
//  Created by Tham En Jie on 13/11/22.
//

import Foundation

enum gender: String, CaseIterable, Identifiable {
    case gender //default
    case male
    case female
    
    var id: gender { self }
}

enum calcPage: String, CaseIterable {
    case none
    case standards
    case calculate
}

struct Workout: Hashable {
    var name: String
    var range: ClosedRange<Int>
    var isInt: Bool // false is less than and also /100
}

let Stations: [String:[Workout]] = [
    "NAPFA": [
        Workout(name: "No. of Sit-ups in 1 min", range: 0...42, isInt: true),
        Workout(name: "Standing Broad Jump", range: 0...251, isInt: true),
        Workout(name: "Sit & Reach Distance", range: 0...48, isInt: true),
        Workout(name: "No. of Inclined Pull-ups in 30 sec", range: 0...26, isInt: true),
        Workout(name: "4 X 10m Shuttle Run", range: 0...1020, isInt: false),
        Workout(name: "2.4 km Run-Walk time (min:sec)", range: 0...1035, isInt: false),
    ],
    "IPPT": [
        Workout(name: "Push-Ups", range: 0...60, isInt: true),
        Workout(name: "Sit-Ups", range: 0...60, isInt: true),
        Workout(name: "2.4km Run", range: 0...1000, isInt: false),
    ],
]
