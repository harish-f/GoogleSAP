//
//  ScoringStandardsView.swift
//  GoogleSAP
//
//  Created by Tham En Jie on 13/11/22.
//

import SwiftUI

struct ScoringStandardsView: View {
    
    @State var ViewGeometry: CGSize = CGSize(width: 0.0, height: 0.0)
    @State var circlePickerScale = 0.0
    
    @Binding var ageInput: Int
    @Binding var genderInput: gender
    
    @State var selected: Int = 0
    @State var scrollSelected: Int = 0
    @State var extraDrag: CGFloat = 0.0
    
    let ABCDE = ["A", "B", "C", "D", "E", "F"]
    
    @State var attainmentCollapsed = false
    @State var attainmentCloseAmount = CGFloat.zero
    
    func intToTime(_ int: Int, isLongDist: Bool) -> String {
        if isLongDist {
            let sec = String(int%60)
            return String(int/60) + ":" + String(repeating: "0", count: (2-sec.count)) + sec
        } else {
            return String(Double(int)/10.0) + "s"
        }
    }
    
    var body: some View {
        ZStack {
            GeometryReader{ geometry in
                Spacer().onAppear { ViewGeometry = geometry.size }
            }
            Color(UIColor.systemBackground)
            let stations = genderInput == .male && ageInput >= 15 ? NAPFAStations.map{ $0 == "No. of Inclined Pull-ups in 30 sec" ? "No. of Pull-ups in 30 sec":$0 }:NAPFAStations
            VStack {
                Text("NAPFA").font(.title).bold().padding(.vertical)
                ZStack {
                    Text("[Bronze] E in all stations & 6 points").padding(15).background(Color(red: 205/255, green: 127/255, blue: 50/255)).cornerRadius(10).offset(y: 0-8)
                    Text("[Silver] D in all stations & 15 points").padding(15).background(Color(red: 192/255, green: 192/255, blue: 192/255)).cornerRadius(10).offset(y: attainmentCollapsed ? attainmentCloseAmount:0)
                    Text("[Gold] C in all stations & 21 points").padding(15).background(Color(red: 255/255, green: 215/255, blue: 0)).cornerRadius(10).offset(y: 8 + (attainmentCollapsed ? attainmentCloseAmount*2:0))
                }.font(.title2).padding(.vertical)
                    .background(GeometryReader { proxy -> Color in
                        DispatchQueue.main.async { attainmentCloseAmount = proxy.size.height/2 }
                        return Color.clear
                    })
                    .overlay {
                        VStack {
                            Spacer()
                            Image(systemName: "chevron.compact.down").foregroundColor(.secondary).padding().rotationEffect(.degrees(attainmentCollapsed ? 0:180)).offset(y: 20 + (attainmentCollapsed ? attainmentCloseAmount*2:0))
                        }
                    }
                    .onTapGesture {
                        withAnimation(.spring()){ attainmentCollapsed.toggle() }
                    }
                VStack {
                    VStack {
                        Text("Requirements for:")
                        Text(stations[selected])
                    }.bold().padding().padding(.top)
                    ForEach(0...ABCDE.count-1, id: \.self) { i in
                        HStack {
                            let reverseI = ABCDE.count-i-1
                            Spacer()
                            let stringRef1 = "[" + ABCDE[i] + "] "
                            let stringRef2 = String(reverseI) + " Points"
                            Text(stringRef1 + stringRef2)
                            Spacer()
                            let ref = NAPFAStandards[genderInput]![ageInput]![selected]
                            if selected < 4 {
                                if i == 0 {
                                    Text("   > " + String(ref[4]-1))
                                } else if reverseI == 0 {
                                    Text("   < " + String(ref[0]))
                                } else {
                                    let ref2 = String(ref[reverseI-1])
                                    let ref3 = String(ref[reverseI]-1)
                                    Text(ref2 + " - " + ref3)
                                }
                            } else {
                                let isLongDist = selected == 5
                                if i == 0 {
                                    Text("   < " + intToTime(ref[0], isLongDist: isLongDist))
                                } else if reverseI == 0 {
                                    Text("   > " + intToTime(ref[4]-1, isLongDist: isLongDist))
                                } else {
                                    let ref2 = intToTime(ref[i-1], isLongDist: isLongDist)
                                    let ref3 = intToTime(ref[i]-1, isLongDist: isLongDist)
                                    Text(ref2 + " - " + ref3)
                                }
                            }
                            Spacer()
                        }
                    }
                }.offset(y: attainmentCollapsed ? attainmentCloseAmount*3:0)
                Spacer()
            }
            ZStack {
                GeometryReader{ geometry in
                    let sideColours = Array(1...Int((Double(stations.count-1)/2)+0.5)).map{ _ in Color(UIColor.secondaryLabel)}
                    Circle()
                        .fill(AngularGradient(
                            colors: sideColours + [Color(UIColor.label)] + sideColours,
                            center: .center,
                            startAngle: .degrees(90),
                            endAngle: .degrees(450)
                        ))
                        .scaleEffect(circlePickerScale*1.5)
                        .onAppear{ withAnimation{ circlePickerScale = 1.0 } }
                        .offset(x: 0, y: ViewGeometry.height-ViewGeometry.height/50)
                }
                let countOffset = 360.0/Double(stations.count)
                ForEach(stations, id: \.self) {
                    Text($0)
                        .bold(stations[selected] == $0)
                        .font(Font.title3)
                        .foregroundColor(Color(UIColor.secondarySystemBackground))
                        .multilineTextAlignment(.center)
                        .frame(width: ViewGeometry.width/3)
                        .padding(.bottom, ViewGeometry.width)
                        .rotationEffect(Angle(
                            degrees: countOffset*Double(stations.firstIndex(of: $0)! - scrollSelected) + countOffset*extraDrag
                        ))
                        .offset(y: (ViewGeometry.height/2-ViewGeometry.height/50)*1.5)
                }
            }
            .gesture(DragGesture()
                .onChanged { drag in
                    extraDrag = 2*(drag.translation.width/ViewGeometry.width)
                }
                .onEnded { drag in
                    var ref = 0
                    if drag.translation.width>ViewGeometry.width/10 { ref = -1 }
                    else if drag.translation.width<0-ViewGeometry.width/10 { ref = 1 }
                    let stationsCount = NAPFAStations.count//updated for napfa only
                    var ref2 = ref
                    if selected+ref<0 { ref2 += stationsCount }
                    if selected+ref>=stationsCount { ref2 -= stationsCount }
                    withAnimation(.spring(response: 0.25, dampingFraction: 0.75)) {
                        extraDrag = 0.0
                        scrollSelected += ref
                        selected += ref2
                    }
                })
        }
    }
}

struct ScoringStandardsView_Previews: PreviewProvider {
    static var previews: some View {
        ScoringStandardsView(ageInput: .constant(14), genderInput: .constant(gender.male))
    }
}
