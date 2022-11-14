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
        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDir.appendingPathExtension(plistName)
    }
    func loadData() {
        let archiveUrl = getArchiveUrl()
        let plistDecoder = PropertyListDecoder()
        
        let finalData: [LogRecord]
        
        if let retrievedData = try? Data(contentsOf: archiveUrl),
           let decodedData = try? plistDecoder.decode(Array<LogRecord>.self, from: retrievedData) {
            finalData = decodedData
        } else {
            finalData = [
                LogRecord(NapfaOrWorkouts: .napfa, description: "This is my description", date: Date(timeInterval: .zero, since: .now), twoPointFourKMRun: "0.1", shuttleRun: "0.2", sitUps: "0.3", sitAndReach: "0.4", inclinedPullups: "0.5", standingBroadJump: "0.6")
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
