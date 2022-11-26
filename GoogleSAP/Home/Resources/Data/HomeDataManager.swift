//
//  RoutinesDataManager.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 12/10/22.
//

import Foundation

class HomeDataManager: ObservableObject {
    @Published var stationData: [UserSetScore] = [
        UserSetScore(age: 0, ageDate: Date(), TwoPointFourKMRun: 0.0, ShuttleRun: 0.0, SitUps: 0.0, SitAndReach: 0.0, InclinedPullups: 0.0, StandingBroadJump: 0.0)
    ]
    
    init() {
        loadData()
    }
    func getArchiveUrl() -> URL {
        let plistName = "UserSetScore.plist"
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDir.appendingPathComponent(plistName)
    }
    func loadData() {
        let archiveUrl = getArchiveUrl()
        let plistDecoder = PropertyListDecoder()
        
        var finalStationData: [UserSetScore]!
        
        if let retrievedData = try? Data(contentsOf: archiveUrl),
           let decodedData = try? plistDecoder.decode(Array<UserSetScore>.self, from: retrievedData){
            finalStationData = decodedData
        } else {
            finalStationData = [
                UserSetScore(age: 0, ageDate: Date(), TwoPointFourKMRun: 0.0, ShuttleRun: 0.0, SitUps: 0.0, SitAndReach: 0.0, InclinedPullups: 0.0, StandingBroadJump: 0.0)
            ]
        }
        stationData = finalStationData
    }
    func saveData() {
        let archiveUrl = getArchiveUrl()
        let plistEncoder = PropertyListEncoder()
        let encodedRoutines = try? plistEncoder.encode(stationData)
        try? encodedRoutines?.write(to: archiveUrl, options: .noFileProtection)
    }
}
