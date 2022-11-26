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
    @Binding var pageType: calcPage
    
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
    func calcToPoints(calc: [Double]) -> [Int] {
        let ref = NAPFAStandards[genderInput]![ageInput]!
        var points = [0,0,0,0,0,0]
        for i in 0...calc.count-1 {
            for j in 0...ref[i].count-1 {
                if Double(ref[i][ref[i].count-1-j]) < calc[i] {
                    points[i] = ref[i].count-j
                    break
                }
            }
        }
        return points
    }
    
    @State var offset = CGFloat.zero
    @State var scrollSize = CGSize.zero
    @State var viewableScrollSize: CGSize
    @State var arrowSize = CGSize.zero
    @State var arrowScale = CGFloat.zero
    
    @State var pageOffset = CGFloat.zero
    
    @State var points = [0,0,0,0,0,0]
    func attainment(_ points: [Int], getTotal: Bool = false) -> String {
        let total = points.reduce(0){ $0 + $1 }
        if getTotal { return String(total) }
        let lowest = points.reduce(points[0]){ $1<$0 ? $1:$0 }
        if total >= 21 && lowest >= 3 { return "GOLD" }
        else if total >= 15 && lowest >= 4 { return "SILVER" }
        else if total >= 6 && lowest >= 5 { return "BRONZE" }
        else { return "NIL" }
    }
    
    let FEDCBA = ["F", "E", "D", "C", "B", "A"]
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    Text("Attainment: " + attainment(points))
                    Text("Total Points: " + attainment(points, getTotal: true))
                }.font(.title).bold().padding().padding(.bottom)
                ForEach(0...NAPFAStations.count-1, id: \.self) { i in
                    let displayValueRef = " [" + displayValues[i] + "]"
                    GroupBox(NAPFAStations[i] + displayValueRef) {
                        let b4Ref = points[i]
                        let intRef = String(b4Ref)
                        Text(intRef)
                    }
                }
                Spacer()
            }.offset(y: (viewableScrollSize.height-pageOffset)*1.5).background(Color(UIColor.systemBackground)).padding(.horizontal)
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
                            if 0.0-offset > viewableScrollSize.height*0.25 {
                                withAnimation(.spring(response: 0.25)){
                                    pageOffset = 0-viewableScrollSize.height
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                    withAnimation(.spring(response: 0.25)){
                                        pageType = .none
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now()+0.25) { pageOffset = .zero }
                                }
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
                .onChange(of: calcValues) { _ in
                    displayValues = calcToDisplay(calc: calcValues)
                    points = calcToPoints(calc: calcValues)
                }
            }.coordinateSpace(name: "scroll").background(Color(UIColor.systemBackground)).offset(y: 0-pageOffset*1.5)
                .overlay {
                    if pageOffset == CGFloat.zero {
                        VStack {
                            Spacer()
                            Text("Swipe Up for Grades").font(.footnote).foregroundColor(.secondary).padding()
                        }
                    }
                }
        }
    }
}

struct GradeScoreCaclulator_Previews: PreviewProvider {
    static var previews: some View {
        GradeScoreCaclulator(ageInput: .constant(14), genderInput: .constant(gender.male), pageType: .constant(calcPage.calculate), viewableScrollSize: CGSize.zero)
    }
}
