//
//  Routine.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 12/10/22.
//

import Foundation


struct Exercise: Identifiable, Codable, Equatable {
    var name: String
    
    var duration: Int
    var reps: Int
    
    var id = UUID()
}

struct Routine: Identifiable, Codable, Equatable {
    var title: String
    var exercises: [Exercise]
    var id = UUID()
}
