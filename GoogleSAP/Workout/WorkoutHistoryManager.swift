//
//  WorkoutHistoryManager.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 14/11/22.
//

import Foundation

struct WorkoutSession: Codable, Identifiable {
    var exercises: [Exercise]
    var date: Date
    
    var id = UUID()
}

class WorkoutHistoryManger: ObservableObject {
    @Published var workoutHistory: [WorkoutSession] = []
    
    init() {
        loadData()
    }
    
    func getArchiveUrl() -> URL {
        let plistName = "workoutHistory.plist"
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDir.appendingPathComponent(plistName)
    }
    
    func loadData() {
        let archiveUrl = getArchiveUrl()
        let plistDecoder = PropertyListDecoder()
        
        var finalHistory: [WorkoutSession]!
        
        if let retrievedData = try? Data(contentsOf: archiveUrl),
           let decodedData = try? plistDecoder.decode(Array<WorkoutSession>.self, from: retrievedData){
            finalHistory = decodedData
        } else {
            finalHistory = [WorkoutSession(exercises: [Exercise(name: "sample", duration: 10, reps: 5)], date: Date.now)]
        }
        workoutHistory = finalHistory
    }
    func saveData() {
        let archiveUrl = getArchiveUrl()
        let plistEncoder = PropertyListEncoder()
        let encodedHistory = try? plistEncoder.encode(workoutHistory)
        try? encodedHistory?.write(to: archiveUrl, options: .noFileProtection)
    }
}
