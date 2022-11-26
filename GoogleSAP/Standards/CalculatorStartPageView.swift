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
    
    @State var insideViewGeometry: CGSize = CGSize(width: 0.0, height: 0.0)
    @State var dragOffset = CGFloat.zero
    @State var screenSize = CGSize.zero
    
    var body: some View {
        ZStack {
            GeometryReader{ geometry in
                Spacer().onAppear { screenSize = geometry.size }
            }
            VStack {
                    HStack(spacing: 0) {
                        Text("I am a")
                        Picker("Age", selection: $ageInput) {
                            Text("Age").tag(0)
                            ForEach(9...19, id: \.self) { //updated for napfa only, ippt up to age 60
                                Text(String($0)).tag($0)
                            }
                        }.frame(maxWidth: .infinity)
                            .overlay {
                                VStack {
                                    Spacer()
                                    Rectangle().fill(ageInput == 0 ? .red:.clear).frame(height: 2).padding(.horizontal).padding(.horizontal)
                                }
                            }
                        Text("year old")
                        Picker("Gender", selection: $genderInput) {
                            ForEach(gender.allCases, id: \.self) {
                                Text($0.rawValue.capitalized)
                            }
                        }.frame(maxWidth: .infinity)
                            .overlay {
                                VStack {
                                    Spacer()
                                    Rectangle().fill(genderInput == .gender ? .red:.clear).frame(height: 2).padding(.horizontal).padding(.horizontal)
                                }
                            }
                    }.pickerStyle(.menu).frame(maxWidth: .infinity).padding().padding(.horizontal)
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
                } else {
                    ZStack {
                        GeometryReader{ geometry in
                            Spacer().onAppear { insideViewGeometry = geometry.size }
                        }
                        VStack {
                            Spacer()
                            Group {
                                if pageType == calcPage.standards {
                                    ScoringStandardsView(ageInput: $ageInput, genderInput: $genderInput)
                                } else if pageType == calcPage.calculate {
                                    GradeScoreCaclulator(ageInput: $ageInput, genderInput: $genderInput, pageType: $pageType, viewableScrollSize: screenSize)
                                }
                            }
                            .offset(y: dragOffset)
                            .gesture(DragGesture()
                                .onChanged({ drag in
                                    dragOffset = drag.translation.height>0 ? drag.translation.height:CGFloat.zero
                                })
                                .onEnded({ drag in
                                    if drag.translation.height>insideViewGeometry.height*0.66 {
                                        withAnimation(.spring(response: 0.25)){
                                            dragOffset = insideViewGeometry.height
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                            withAnimation(.spring(response: 0.25)){
                                                pageType = .none
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now()+0.25) { dragOffset = .zero }
                                        }
                                    } else { withAnimation(.spring()){ dragOffset = CGFloat.zero } }
                                })
                            )
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

struct CalculatorStartPageView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorStartPageView()
    }
}
