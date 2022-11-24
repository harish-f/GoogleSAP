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

struct Workout: Hashable {
    var name: String
    var range: ClosedRange<Int>
    var isInt: Bool // false is less than and also /100
}

let Stations: [String:[Workout]] = [//Add overall one for each maybe
    "NAPFA": [
        Workout(name: "No. of Sit-ups in 1 min", range: 0...42, isInt: true),
        Workout(name: "Standing Broad Jump", range: 0...251, isInt: true),
        Workout(name: "Sit & Reach Distance", range: 0...48, isInt: true),
        Workout(name: "No. of Inclined Pull-ups in 30 sec", range: 0...26, isInt: true),
        Workout(name: "4 X 10m Shuttle Run", range: 0...1020, isInt: false),
        Workout(name: "2.4 km Run-Walk time (min:sec)", range: 0...1035, isInt: false),
    ],
    "IPPT": [
        Workout(name: "Push-Ups", range: 0...60, isInt: true),
        Workout(name: "Sit-Ups", range: 0...60, isInt: true),
        Workout(name: "2.4km Run", range: 0...1000, isInt: false),
    ],
]

let NAPFAStandards: [gender:[Int:[[Int]]]] = [
    .male: [
        9: [
            [ 14, 19, 24, 29, 35 ],  // Sit-ups
            [ 129, 138, 148, 158, 169 ],  // SBJ
            [ 8, 15, 22, 29, 36 ],  // Sit & Reach
            [ 1, 4, 8, 17, 26 ],  // (Inclined) Pull-Ups
            [ 0, 0, 0, 0, 0 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        10: [
            [ 16, 20, 25, 30, 36 ],  // Sit-ups
            [ 136, 145, 155, 164, 174 ],  // SBJ
            [ 10, 17, 24, 31, 38 ],  // Sit & Reach
            [ 1, 5, 9, 18, 27 ],  // (Inclined) Pull-Ups
            [ 0, 0, 0, 0, 0 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        11: [
            [ 19, 24, 29, 33, 39 ],  // Sit-ups
            [ 143, 154, 165, 176, 188 ],  // SBJ
            [ 12, 19, 26, 33, 40 ],  // Sit & Reach
            [ 1, 5, 9, 18, 27 ],  // (Inclined) Pull-Ups
            [ 0, 0, 0, 0, 0 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        12: [
            [ 21, 26, 31, 35, 41 ],  // Sit-ups
            [ 149, 162, 175, 188, 202 ],  // SBJ
            [ 14, 21, 28, 35, 42 ],  // Sit & Reach
            [ 1, 5, 9, 18, 27 ],  // (Inclined) Pull-Ups
            [ 0, 0, 0, 0, 0 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        13: [
            [ 24, 28, 33, 37, 42 ],  // Sit-ups
            [ 163, 175, 188, 201, 214 ],  // SBJ
            [ 16, 23, 30, 37, 44 ],  // Sit & Reach
            [ 2, 6, 10, 19, 28 ],  // (Inclined) Pull-Ups
            [ 0, 0, 0, 0, 0 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        14: [
            [ 28, 32, 36, 39, 42 ],  // Sit-ups
            [ 185, 195, 205, 215, 225 ],  // SBJ
            [ 26, 31, 35, 39, 43 ],  // Sit & Reach
            [ 7, 12, 17, 22, 26 ],  // (Inclined) Pull-Ups
            [ 0, 0, 0, 0, 0 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        15: [
            [ 29, 33, 36, 39, 42 ],  // Sit-ups
            [ 197, 207, 217, 227, 237 ],  // SBJ
            [ 28, 33, 37, 41, 45 ],  // Sit & Reach
            [ 0, 2, 4, 5, 7 ],  // (Inclined) Pull-Ups
            [ 0, 0, 0, 0, 0 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        16: [
            [ 30, 33, 36, 39, 42 ],  // Sit-ups
            [ 205, 215, 225, 235, 245 ],  // SBJ
            [ 30, 35, 39, 43, 47 ],  // Sit & Reach
            [ 0, 2, 4, 6, 8 ],  // (Inclined) Pull-Ups
            [ 0, 0, 0, 0, 0 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        17: [
            [ 30, 33, 36, 39, 42 ],  // Sit-ups
            [ 209, 219, 229, 239, 249 ],  // SBJ
            [ 31, 36, 40, 44, 48 ],  // Sit & Reach
            [ 1, 3, 5, 7, 9 ],  // (Inclined) Pull-Ups
            [ 0, 0, 0, 0, 0 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        18: [
            [ 30, 33, 36, 39, 42 ],  // Sit-ups
            [ 211, 221, 231, 241, 251 ],  // SBJ
            [ 31, 36, 40, 44, 48 ],  // Sit & Reach
            [ 2, 4, 6, 7, 10 ],  // (Inclined) Pull-Ups
            [ 0, 0, 0, 0, 0 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        19: [
            [ 30, 33, 36, 39, 42 ],  // Sit-ups
            [ 211, 221, 231, 241, 251 ],  // SBJ
            [ 31, 36, 40, 44, 48 ],  // Sit & Reach
            [ 2, 4, 6, 8, 10 ],  // (Inclined) Pull-Ups
            [ 0, 0, 0, 0, 0 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
    ],
    .female: [
        9: [
            [ 9, 13, 17, 21, 26 ],  // Sit-ups
            [ 118, 128, 138, 147, 158 ],  // SBJ
            [ 10, 17, 24, 31, 37 ],  // Sit & Reach
            [ 1, 4, 8, 15, 22 ],  // (Inclined) Pull-Ups
            [ 0, 0, 0, 0, 0 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        10: [
            [ 10, 14, 18, 22, 27 ],  // Sit-ups
            [ 124, 133, 142, 151, 161 ],  // SBJ
            [ 12, 19, 26, 33, 39 ],  // Sit & Reach
            [ 1, 3, 7, 14, 21 ],  // (Inclined) Pull-Ups
            [ 0, 0, 0, 0, 0 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        11: [
            [ 11, 15, 19, 23, 28 ],  // Sit-ups
            [ 128, 137, 146, 155, 164 ],  // SBJ
            [ 14, 21, 28, 35, 41 ],  // Sit & Reach
            [ 1, 2, 6, 13, 20 ],  // (Inclined) Pull-Ups
            [ 0, 0, 0, 0, 0 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        12: [
            [ 12, 16, 20, 24, 29 ],  // Sit-ups
            [ 131, 140, 149, 158, 167 ],  // SBJ
            [ 16, 23, 30, 37, 43 ],  // Sit & Reach
            [ 0, 2, 5, 12, 19 ],  // (Inclined) Pull-Ups
            [ 0, 0, 0, 0, 0 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        13: [
            [ 13, 17, 21, 25, 30 ],  // Sit-ups
            [ 134, 143, 152, 161, 170 ],  // SBJ
            [ 18, 25, 32, 39, 45 ],  // Sit & Reach
            [ 0, 1, 3, 10, 17 ],  // (Inclined) Pull-Ups
            [ 0, 0, 0, 0, 0 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        14: [
            [ 15, 19, 23, 27, 30 ],  // Sit-ups
            [ 141, 150, 159, 168, 177 ],  // SBJ
            [ 28, 33, 37, 40, 43 ],  // Sit & Reach
            [ 2, 6, 9, 13, 17 ],  // (Inclined) Pull-Ups
            [ 0, 0, 0, 0, 0 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        15: [
            [ 16, 20, 24, 28, 30 ],  // Sit-ups
            [ 146, 155, 164, 173, 182 ],  // SBJ
            [ 29, 34, 38, 42, 45 ],  // Sit & Reach
            [ 2, 6, 9, 13, 16 ],  // (Inclined) Pull-Ups
            [ 0, 0, 0, 0, 0 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        16: [
            [ 17, 21, 25, 28, 31 ],  // Sit-ups
            [ 150, 159, 168, 177, 186 ],  // SBJ
            [ 30, 35, 39, 43, 46 ],  // Sit & Reach
            [ 2, 6, 10, 13, 17 ],  // (Inclined) Pull-Ups
            [ 0, 0, 0, 0, 0 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        17: [
            [ 18, 21, 25, 28, 30 ],  // Sit-ups
            [ 153, 162, 171, 180, 189 ],  // SBJ
            [ 31, 35, 39, 43, 46 ],  // Sit & Reach
            [ 2, 6, 10, 13, 16 ],  // (Inclined) Pull-Ups
            [ 0, 0, 0, 0, 0 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        18: [
            [ 19, 23, 26, 28, 30 ],  // Sit-ups
            [ 155, 164, 0173, 182, 192 ],  // SBJ
            [ 31, 35, 39, 43, 46 ],  // Sit & Reach
            [ 3, 7, 10, 14, 17 ],  // (Inclined) Pull-Ups
            [ 0, 0, 0, 0, 0 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
        19: [
            [ 20, 23, 26, 28, 30 ],  // Sit-ups
            [ 155, 164, 173, 184, 195 ],  // SBJ
            [ 31, 35, 38, 42, 45 ],  // Sit & Reach
            [ 4, 7, 10, 14, 17 ],  // (Inclined) Pull-Ups
            [ 0, 0, 0, 0, 0 ],  // Shuttle Run
            [ 0, 0, 0, 0, 0 ],  // 1.6km / 2.4km
        ],
    ]
]

