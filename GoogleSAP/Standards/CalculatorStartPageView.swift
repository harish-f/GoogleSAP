//
//  CalculatorStartPageView.swift
//  GoogleSAP
//
//  Created by Tham En Jie on 13/11/22.
//

import SwiftUI

struct CalculatorStartPageView: View {
    
    @State var ageInput: Int = 0
    @State var genderInput: gender = .gender
    @State var pageType: calcPage = .none
    
    var body: some View {
        VStack {
                HStack(spacing: 0) {
                    Text("I am a")
                    Picker("Age", selection: $ageInput) {
                        Text("Age").tag(0)
                        ForEach(9...60, id: \.self) {
                            Text(String($0)).tag($0)
                        }
                    }.overlay {
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Spacer()
                                Rectangle().fill(ageInput == 0 ? .red:.clear).frame(height: 2)
                                Spacer()
                                Spacer()
                            }
                        }
                    }
                    Text("year old")
                    Picker("Gender", selection: $genderInput) {
                        ForEach(gender.allCases, id: \.self) {
                            Text($0.rawValue.capitalized)
                        }
                    }.overlay {
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Spacer()
                                Rectangle().fill(genderInput == .gender ? .red:.clear).frame(height: 2)
                                Spacer()
                                Spacer()
                            }
                        }
                    }
                }.pickerStyle(.menu).padding(.vertical) //fix text wrapping
            if pageType == calcPage.none || ageInput == 0 || genderInput == .gender { //should switch to switch case?
                ForEach(calcPage.allCases, id: \.self) { page in
                    if page != calcPage.none {
                        Button(page.rawValue.capitalized) {
                            withAnimation{ pageType = page }
                        }.buttonStyle(.borderedProminent)
                            .disabled(ageInput == 0 || genderInput == .gender)
                    }
                }.onAppear {
                    withAnimation{ pageType = .none }
                }
            } else if pageType == calcPage.standards {
                Spacer()
                ScoringStandardsView(ageInput: ageInput)
                Spacer()
            } else if pageType == calcPage.calculate {
                Spacer()
                GradeScoreCaclulator()
                Spacer()
            }//add pull down to reset age and gender
        }
    }
}

struct CalculatorStartPageView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorStartPageView()
    }
}
