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
        } else {finalRoutines = []}
        routines = finalRoutines
    }
    func saveData() {
        let archiveUrl = getArchiveUrl()
        let plistEncoder = PropertyListEncoder()
        let encodedRoutines = try? plistEncoder.encode(routines)
        try? encodedRoutines?.write(to: archiveUrl, options: .noFileProtection)
    }
}
