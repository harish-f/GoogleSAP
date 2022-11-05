//
//  RoutinesDataManager.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 12/10/22.
//

import Foundation

class HomeDataManager: ObservableObject {
    @Published var stationData: [station] = [
        station(_name: .SitUps, lastNapfaScore: 0.0, topNapfaScore: 0.0, lastExerciseScore: 0.0, topExerciseScore: 0.0)
    ]
    init() {
        loadData()
    }
    func getArchiveUrl() -> URL {
        let plistName = "StationData.plist"
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDir.appendingPathComponent(plistName)
    }
    func loadData() {
        let archiveUrl = getArchiveUrl()
        let plistDecoder = PropertyListDecoder()
        
        var finalStationData: [station]!
        
        if let retrievedData = try? Data(contentsOf: archiveUrl),
           let decodedData = try? plistDecoder.decode(Array<station>.self, from: retrievedData){
            finalStationData = decodedData
        } else {finalStationData = []}
        stationData = finalStationData
    }
    func saveData() {
        let archiveUrl = getArchiveUrl()
        let plistEncoder = PropertyListEncoder()
        let encodedRoutines = try? plistEncoder.encode(stationData)
        try? encodedRoutines?.write(to: archiveUrl, options: .noFileProtection)
    }
}
