//
//  DataTypes.swift
//  GoogleSAP
//
//  Created by Tham En Jie on 13/11/22.
//

import Foundation

enum gender: String, CaseIterable, Identifiable {
    case gender //default
    case male
    case female
    
    var id: gender { self }
}

enum calcPage: String, CaseIterable {
    case none
    case standards
    case calculate
}
