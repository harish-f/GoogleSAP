//
//  Routine.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 12/10/22.
//

import Foundation

struct Exercise: Codable {
    var name: String
    
    var time: Int
}

struct Routine: Identifiable, Codable, Equatable {
    var title: String
    var id = UUID()
}
