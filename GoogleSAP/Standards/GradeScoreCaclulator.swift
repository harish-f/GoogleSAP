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
    
    @State var offset = CGFloat.zero
    @State var scrollSize = CGSize.zero
    @State var viewableScrollSize: CGSize
    @State var arrowSize = CGSize.zero
    @State var arrowScale = CGFloat.zero
    
    @State var pageOffset = CGFloat.zero
    
    var body: some View {
        ZStack {
            VStack {
                Text("Grade").font(.title).bold()
                Spacer()
            }.offset(y: (viewableScrollSize.height-pageOffset)*1.5)
            let ref = NAPFAStandards[genderInput]![ageInput]!
            ScrollView(.vertical) {
                VStack {
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
                        Image(systemName: "arrow.up.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(GeometryReader { proxy -> Color in
                                DispatchQueue.main.async { arrowSize = proxy.size }
                                return Color.clear
                            })
                            .scaleEffect(arrowScale)
                    }.background(GeometryReader { proxy -> Color in
                        DispatchQueue.main.async {
                            offset = -proxy.frame(in: .named("scroll")).origin.y
                            scrollSize = proxy.size
                            if offset < round(scrollSize.height-viewableScrollSize.height) {
                                arrowScale = offset/((scrollSize.height-arrowSize.height)/2)
                                withAnimation(.spring(response: 0.5)) { pageOffset = CGFloat.zero }
                            } else {
                                arrowScale = round(scrollSize.height-viewableScrollSize.height)/((scrollSize.height-arrowSize.height)/2)
                                if offset >= round(scrollSize.height-viewableScrollSize.height)*1.25 {
                                    withAnimation(.spring(response: 0.5)) { pageOffset = viewableScrollSize.height }
                                }
                            }
                        }
                        return Color.clear
                    })
                }.onAppear {
                    calcValues = ref.map{ Double($0[0]-1) }
                    displayValues = calcToDisplay(calc: calcValues)
                }
            }.coordinateSpace(name: "scroll").offset(y: 0-pageOffset*1.5)
        }
    }
}

struct GradeScoreCaclulator_Previews: PreviewProvider {
    static var previews: some View {
        GradeScoreCaclulator(ageInput: .constant(14), genderInput: .constant(gender.male), viewableScrollSize: CGSize.zero)
    }
}
