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

let NAPFAStations: [String] = [
    "No. of Sit-ups in 1 min",
    "Standing Broad Jump",
    "Sit & Reach Distance",
    "No. of Inclined Pull-ups in 30 sec",
    "4 X 10m Shuttle Run",
    "2.4 km Run-Walk time (min:sec)"
]

let NAPFAStandards: [gender:[Int:[[Int]]]] = [
    .male: [
        9: [
            [ 15, 20, 25, 30, 36 ],  // Sit-ups
            [ 130, 139, 149, 159, 169 ],  // SBJ
            [ 16, 21, 26, 30, 34 ],  // Sit & Reach
            [ 3, 9, 13, 18, 22 ],  // (Inclined) Pull-Ups
            [ 113, 119, 123, 128, 132 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        10: [
            [ 17, 21, 26, 31, 37 ],  // Sit-ups
            [ 137, 146, 156, 165, 175 ],  // SBJ
            [ 18, 23, 28, 32, 36 ],  // Sit & Reach
            [ 3, 9, 14, 19, 23 ],  // (Inclined) Pull-Ups
            [ 111, 117, 121, 125, 130 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        11: [
            [ 20, 25, 30, 34, 40 ],  // Sit-ups
            [ 144, 155, 166, 177, 189 ],  // SBJ
            [ 20, 25, 30, 34, 38 ],  // Sit & Reach
            [ 4, 10, 15, 20, 24 ],  // (Inclined) Pull-Ups
            [ 107, 113, 117 , 121, 126 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        12: [
            [ 22, 27, 32, 36, 42 ],  // Sit-ups
            [ 150, 163, 176, 189, 203 ],  // SBJ
            [ 23, 28, 32, 36, 40 ],  // Sit & Reach
            [ 5, 11, 16, 21, 25 ],  // (Inclined) Pull-Ups
            [ 104, 110, 114, 118, 123 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        13: [
            [ 25, 29, 34, 38, 43 ],  // Sit-ups
            [ 164, 176, 189, 202, 215 ],  // SBJ
            [ 25, 30, 34, 38, 42 ],  // Sit & Reach
            [ 7, 12, 17, 22, 26 ],  // (Inclined) Pull-Ups
            [ 103, 108, 112, 116, 120 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        14: [
            [ 29, 33, 37, 40, 43 ],  // Sit-ups
            [ 186, 196, 206, 216, 226 ],  // SBJ
            [ 27, 32, 36, 40, 44 ],  // Sit & Reach
            [ 8, 13, 18, 23, 27 ],  // (Inclined) Pull-Ups
            [ 102, 105, 109, 113, 117 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        15: [
            [ 30, 34, 37, 40, 43 ],  // Sit-ups
            [ 198, 208, 218, 228, 238 ],  // SBJ
            [ 29, 34, 38, 42, 46 ],  // Sit & Reach
            [ 1, 3, 5, 6, 8 ],  // (Inclined) Pull-Ups
            [ 102, 104, 106, 110, 114 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        16: [
            [ 31, 34, 37, 40, 43 ],  // Sit-ups
            [ 206, 216, 226, 236, 246 ],  // SBJ
            [ 31, 36, 40, 44, 48 ],  // Sit & Reach
            [ 1, 3, 5, 7, 9 ],  // (Inclined) Pull-Ups
            [ 102, 104, 106, 108, 112 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        17: [
            [ 31, 34, 37, 40, 43 ],  // Sit-ups
            [ 210, 220, 230, 240, 250 ],  // SBJ
            [ 32, 37, 41, 45, 49 ],  // Sit & Reach
            [ 2, 4, 6, 8, 10 ],  // (Inclined) Pull-Ups
            [ 102, 104, 106, 108, 110 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        18: [
            [ 31, 34, 37, 40, 43 ],  // Sit-ups
            [ 212, 222, 232, 242, 252 ],  // SBJ
            [ 32, 37, 41, 45, 49 ],  // Sit & Reach
            [ 3, 5, 7, 9, 11 ],  // (Inclined) Pull-Ups
            [ 102, 104, 106, 108, 110 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        19: [
            [ 31, 34, 37, 40, 43 ],  // Sit-ups
            [ 212, 222, 232, 242, 252 ],  // SBJ
            [ 32, 37, 41, 45, 49 ],  // Sit & Reach
            [ 3, 5, 7, 9, 11 ],  // (Inclined) Pull-Ups
            [ 102, 104, 106, 108, 110 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
    ],
    .female: [
        9: [
            [ 10, 14, 18, 22, 27 ],  // Sit-ups
            [ 119, 129, 139, 148, 159 ],  // SBJ
            [ 19, 24, 28, 31, 34 ],  // Sit & Reach
            [ 2, 8, 9, 12, 15 ],  // (Inclined) Pull-Ups
            [ 118, 124, 129, 134, 139 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        10: [
            [ 11, 15, 19, 23, 28 ],  // Sit-ups
            [ 125, 134, 143, 152, 162 ],  // SBJ
            [ 21, 26, 30, 33, 36 ],  // Sit & Reach
            [ 3, 6, 9, 12, 15 ],  // (Inclined) Pull-Ups
            [ 117, 123, 128, 133, 138 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        11: [
            [ 12, 16, 20, 24, 29 ],  // Sit-ups
            [ 129, 138, 147, 156, 165 ],  // SBJ
            [ 23, 28, 32, 35, 38 ],  // Sit & Reach
            [ 3, 7, 10, 13, 16 ],  // (Inclined) Pull-Ups
            [ 116, 122, 126, 130, 135 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        12: [
            [ 13, 17, 21, 25, 30 ],  // Sit-ups
            [ 132, 141, 150, 159, 168 ],  // SBJ
            [ 25, 30, 34, 37, 40 ],  // Sit & Reach
            [ 3, 7, 10, 13, 16 ],  // (Inclined) Pull-Ups
            [ 115, 120, 124, 128, 133 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        13: [
            [ 14, 18, 22, 26, 31 ],  // Sit-ups
            [ 135, 144, 153, 162, 171 ],  // SBJ
            [ 27, 32, 36, 39, 42 ],  // Sit & Reach
            [ 3, 7, 10, 13, 17 ],  // (Inclined) Pull-Ups
            [ 113, 118, 123, 128, 133 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        14: [
            [ 16, 20, 24, 28, 31 ],  // Sit-ups
            [ 142, 151, 160, 169, 178 ],  // SBJ
            [ 29, 34, 38, 41, 44 ],  // Sit & Reach
            [ 3, 7, 10, 14, 17 ],  // (Inclined) Pull-Ups
            [ 115, 119, 123, 127, 131 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        15: [
            [ 17, 21, 25, 29, 31 ],  // Sit-ups
            [ 147, 156, 165, 174, 183 ],  // SBJ
            [ 30, 35, 39, 43, 46 ],  // Sit & Reach
            [ 3, 7, 10, 14, 17 ],  // (Inclined) Pull-Ups
            [ 113, 117, 121, 125, 129 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        16: [
            [ 18, 22, 26, 29, 31 ],  // Sit-ups
            [ 151, 160, 169, 178, 187 ],  // SBJ
            [ 31, 36, 40, 44, 47 ],  // Sit & Reach
            [ 3, 7, 11, 14, 18 ],  // (Inclined) Pull-Ups
            [ 113, 116, 119, 123, 127 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        17: [
            [ 19, 23, 27, 29, 31 ],  // Sit-ups
            [ 154, 163, 172, 181, 190 ],  // SBJ
            [ 32, 36, 40, 44, 47 ],  // Sit & Reach
            [ 3, 7, 11, 14, 18 ],  // (Inclined) Pull-Ups
            [ 113, 116, 119, 122, 126 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        18: [
            [ 20, 24, 27, 29, 31 ],  // Sit-ups
            [ 156, 165, 174, 183, 193 ],  // SBJ
            [ 32, 36, 40, 44, 47 ],  // Sit & Reach
            [ 4, 8, 11, 15, 18 ],  // (Inclined) Pull-Ups
            [ 113, 116, 119, 122, 125 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        19: [
            [ 21, 24, 27, 29, 31 ],  // Sit-ups
            [ 156, 165, 174, 185, 196 ],  // SBJ
            [ 32, 36, 39, 43, 46 ],  // Sit & Reach
            [ 5, 8, 11, 15, 18 ],  // (Inclined) Pull-Ups
            [ 113, 116, 119, 122, 125 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
    ]
]

