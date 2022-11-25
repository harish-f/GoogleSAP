//
//  GradeScoreCaclulator.swift
//  GoogleSAP
//
//  Created by Tham En Jie on 13/11/22.
//

import SwiftUI

struct GradeScoreCaclulator: View {
    
    @Binding var ageInput: Int
    @Binding var genderInput: gender
    
    @State var calcValues: [Double] = [0.0,0.0,0.0,0.0,0.0,0.0]
    @State var displayValues: [String] = ["","","","","",""]
    func calcToDisplay(calc: [Double]) -> [String] {
        let ref = NAPFAStandards[genderInput]![ageInput]!
        return calc.map {
            let i = calc.firstIndex(of: $0)!
            if $0 < Double(ref[i][0]) {
                return "< " + String(ref[i][0])
            } else if $0 > Double(ref[i][4]) {
                return "> " + String(ref[i][4])
            } else {
                return String(Int($0))
            }
        }
    }
    
    var body: some View {
        let ref = NAPFAStandards[genderInput]![ageInput]!
        ScrollView(.vertical) {
            VStack {
                ForEach(0...NAPFAStations.count-1, id: \.self) { i in
                    VStack {
                        HStack {
                            Text(NAPFAStations[i])
                            Spacer()
                            Text(displayValues[i])
                        }
                        Slider(value: $calcValues[i], in: Double(ref[i][0]-1)...Double(ref[i][4]+1), step: 1)
                            .onChange(of: calcValues) { _ in
                                displayValues = calcToDisplay(calc: calcValues)
                            }
                    }.padding().padding(.horizontal)
                }
            }.onAppear {
                calcValues = ref.map{ Double($0[0]-1) }
                displayValues = calcToDisplay(calc: calcValues)
            }
        }
    }
}

struct GradeScoreCaclulator_Previews: PreviewProvider {
    static var previews: some View {
        GradeScoreCaclulator(ageInput: .constant(14), genderInput: .constant(gender.male))
    }
}
