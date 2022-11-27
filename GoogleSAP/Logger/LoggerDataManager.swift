//
//  LoggerDataManager.swift
//  GoogleSAP
//
//  Created by Sairam Suresh on 14/11/22.
//

import Foundation

class LoggerDataManager: ObservableObject {
    @Published var logRecords: [LogRecord] = []
    init() {
        loadData()
    }
    func getArchiveUrl() -> URL {
        let plistName = "loggerData.plist"
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDir.appendingPathComponent(plistName)
    }
    func loadData() {
        let archiveUrl = getArchiveUrl()
        let plistDecoder = PropertyListDecoder()
        
        let finalData: [LogRecord]!
        
        if let retrievedData = try? Data(contentsOf: archiveUrl),
           let decodedData = try? plistDecoder.decode(Array<LogRecord>.self, from: retrievedData) {
            finalData = decodedData
        } else {
            finalData = [
//                LogRecord(NapfaOrWorkouts: .napfa, description: "This is my description", date: Date(timeInterval: .zero, since: .now), twoPointFourKMRun: "118.5", shuttleRun: "30", sitUps: "21", sitAndReach: "22.5", inclinedPullups: "0.1", standingBroadJump: "118.5"),
//                LogRecord(NapfaOrWorkouts: .workout, description: "This is my description", date: Date(timeInterval: .zero, since: .now), twoPointFourKMRun: "118.5", shuttleRun: "30", sitUps: "21", sitAndReach: "22.5", inclinedPullups: "0.1", standingBroadJump: "118.5"),
            ]
        }
        logRecords = finalData
    }
    func saveData() {
        let archiveUrl = getArchiveUrl()
        let plistEncoder = PropertyListEncoder()
        let encodedData = try? plistEncoder.encode(logRecords)
        try? encodedData?.write(to: archiveUrl, options: .noFileProtection)
    }
}
