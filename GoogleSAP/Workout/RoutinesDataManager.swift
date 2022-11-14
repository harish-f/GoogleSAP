//
//  RoutinesDataManager.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 12/10/22.
//

import Foundation

class RoutinesDataManager: ObservableObject {
    @Published var routines: [Routine] = []
    init() {
        loadData()
    }
    func getArchiveUrl() -> URL {
        let plistName = "routinesData.plist"
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDir.appendingPathComponent(plistName)
    }
    func loadData() {
        let archiveUrl = getArchiveUrl()
        let plistDecoder = PropertyListDecoder()
        
        var finalRoutines: [Routine]!
        
        if let retrievedData = try? Data(contentsOf: archiveUrl),
           let decodedData = try? plistDecoder.decode(Array<Routine>.self, from: retrievedData){
            finalRoutines = decodedData
        } else {
            finalRoutines = [
                Routine(title: "Sunday", exercises: [Exercise(name: "pushup", duration: 30, reps: 30)]),
                Routine(title: "Monday", exercises: [Exercise(name: "pushup", duration: 30, reps: 30)]),
                Routine(title: "Tuesday", exercises: [Exercise(name: "pushup", duration: 30, reps: 30)]),
                Routine(title: "Wednesday", exercises: [Exercise(name: "pushup", duration: 30, reps: 30)]),
                Routine(title: "Thursday", exercises: [Exercise(name: "pushup", duration: 30, reps: 30)]),
                Routine(title: "Friday", exercises: [Exercise(name: "pushup", duration: 30, reps: 30)]),
                Routine(title: "Saturday", exercises: [Exercise(name: "pushup", duration: 30, reps: 30)]),
            ]
        }
        routines = finalRoutines
    }
    func saveData() {
        let archiveUrl = getArchiveUrl()
        let plistEncoder = PropertyListEncoder()
        let encodedRoutines = try? plistEncoder.encode(routines)
        try? encodedRoutines?.write(to: archiveUrl, options: .noFileProtection)
    }
}
