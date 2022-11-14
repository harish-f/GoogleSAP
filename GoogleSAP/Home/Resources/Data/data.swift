//
//  data.swift
//  GoogleSAP
//
//  Created by Sairam Suresh on 22/10/22.
//

import Foundation

enum _Stations: Codable {
    case TwoPointFourKMRun
    case ShuttleRun
    case SitUps
    case SitAndReach
    case InclinedPullups
    case StandingBroadJump
}

struct station: Codable, Identifiable, Equatable {
    let _name: _Stations
    let lastNapfaScore: Double
    let topNapfaScore: Double
    let lastExerciseScore: Double
    let topExerciseScore: Double
    let actualName: String
    var id = UUID()
    
    init(_name: _Stations, lastNapfaScore: Double, topNapfaScore: Double, lastExerciseScore: Double, topExerciseScore: Double) {
        self._name = _name
        self.lastNapfaScore = lastNapfaScore
        self.topNapfaScore = topNapfaScore
        self.lastExerciseScore = lastExerciseScore
        self.topExerciseScore = topExerciseScore
        
        switch _name {
        case .TwoPointFourKMRun: self.actualName = "2.4 KM Run"
        case .ShuttleRun: self.actualName = "Shuttle Run"
        case .SitUps: self.actualName = "Situps"
        case .SitAndReach: self.actualName = "Sit And Reach"
        case .InclinedPullups: self.actualName = "Inclined Pullups"
        case .StandingBroadJump: self.actualName = "Standing Broad Jump"
        }
    }
}
