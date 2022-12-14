//
//  data.swift
//  GoogleSAP
//
//  Created by Sairam Suresh on 22/10/22.
//

import Foundation

struct UserSetScore: Codable, Hashable, Identifiable {
    var id = UUID()
    var gender: String
    let hasUserNotSawInstructions: Bool
    let age: Int
    let ageDate: Date
    let TwoPointFourKMRun: Double
    let ShuttleRun: Double
    let SitUps: Double
    let SitAndReach: Double
    let InclinedPullups: Double
    let StandingBroadJump: Double
}

