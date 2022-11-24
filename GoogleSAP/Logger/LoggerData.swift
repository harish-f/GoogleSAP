//
//  data.swift
//  GoogleSAP
//
//  Created by Sairam Suresh on 14/11/22.
//

import Foundation

enum _stations: Codable, Equatable {
    case TwoPointFourKMRun
    case ShuttleRun
    case SitUps
    case SitAndReach
    case InclinedPullups
    case StandingBroadJump
}

enum NapfaOrWorkout: Codable, Equatable {
    case napfa
    case workout
    
    func getValue() -> String {
        switch self {
        case .napfa:
            return "Napfa"
        
        case .workout:
            return "workout"
        
        }
    }
}

//struct LogRecordStation: Codable, Identifiable, Equatable {
//    let Name: _stations
//    let score: Float
//    let name: String
//
//    var id = UUID()
//
//    init(Name: _stations, score: Float) {
//        self.Name = Name
//        self.score = score
//
//        switch Name {
//        case .TwoPointFourKMRun: self.name = "2.4 KM Run"
//        case .ShuttleRun: self.name = "Shuttle Run"
//        case .SitUps: self.name = "Situps"
//        case .SitAndReach: self.name = "Sit And Reach"
//        case .InclinedPullups: self.name = "Inclined Pullups"
//        case .StandingBroadJump: self.name = "Standing Broad Jump"
//        }
//    }
//}

struct LogRecord: Codable, Identifiable, Equatable {
    let NapfaOrWorkouts: NapfaOrWorkout
    let description: String
    let date: Date
    let napfaOrWorkout: String
    let twoPointFourKMRun: String
    let shuttleRun: String
    let sitUps: String
    let sitAndReach: String
    let inclinedPullups: String
    let standingBroadJump: String
    var id = UUID()
    
    init(NapfaOrWorkouts: NapfaOrWorkout, description: String, date: Date, twoPointFourKMRun:  String, shuttleRun:  String, sitUps:  String, sitAndReach:  String, inclinedPullups: String, standingBroadJump: String) {
        self.NapfaOrWorkouts = NapfaOrWorkouts
        self.description = description
        self.date = date
        self.twoPointFourKMRun = twoPointFourKMRun
        self.shuttleRun = shuttleRun
        self.sitUps = sitUps
        self.sitAndReach = sitAndReach
        self.inclinedPullups = inclinedPullups
        self.standingBroadJump = standingBroadJump
        self.napfaOrWorkout = NapfaOrWorkouts.getValue()
    }
}
