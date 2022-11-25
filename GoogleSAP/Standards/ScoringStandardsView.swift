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
    
    var body: some View {
        ZStack {
            GeometryReader{ geometry in
                Spacer().onAppear { ViewGeometry = geometry.size }
            }
            Color(UIColor.systemBackground)
            let stations = genderInput == .male && ageInput >= 15 ? NAPFAStations.map{ $0 == "No. of Inclined Pull-ups in 30 sec" ? "No. of Pull-ups in 30 sec":$0 }:NAPFAStations
            VStack {
                Text("NAPFA").font(.title).bold().padding(.vertical)
                VStack {
                    Group {
                        Text("[Gold] C in all stations & 21 points").padding().background(Color(red: 255/255, green: 215/255, blue: 0))
                        Text("[Silver] D in all stations & 15 points").padding().background(Color(red: 192/255, green: 192/255, blue: 192/255))
                        Text("[Bronze] E in all stations & 6 points").padding().background(Color(red: 205/255, green: 127/255, blue: 50/255))
                    }.cornerRadius(10)
                }.font(.title2).padding(.vertical)
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
                            if i == 0 {
                                Text("> " + String(ref[4]))
                            } else {
                                let ref2 = reverseI == 0 ? "0":String(ref[reverseI-1])
                                let ref3 = String(ref[reverseI])
                                Text(ref2 + " - " + ref3)
                            }
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
            Group {
                GeometryReader{ geometry in
                    let sideColours = Array(1...Int((Double(stations.count-1)/2)+0.5)).map{ _ in Color(UIColor.secondaryLabel)}
                    Circle()
                        .fill(AngularGradient(
                            colors: sideColours + [Color(UIColor.label)] + sideColours,
                            center: .center,
                            startAngle: .degrees(90),
                            endAngle: .degrees(450)
                        ))
                        .frame(width: ViewGeometry.width*1.5, height: ViewGeometry.height*1.5)
                        .scaleEffect(circlePickerScale)
                        .offset(x: 0-ViewGeometry.width/4, y: ViewGeometry.height/2-ViewGeometry.height/50)
                        .onAppear{ withAnimation{ circlePickerScale = 1.0 } }
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
//                .onChanged { drag in
//                    print()
//                    print(drag.location.x)
//                    print(drag.startLocation.x)
//                    print((drag.location.x-drag.startLocation.x))
//                    print((drag.location.x+drag.startLocation.x))
//                    print((drag.location.x-drag.startLocation.x)/drag.startLocation.x)
//                    print((drag.location.x+drag.startLocation.x)/drag.startLocation.x)
//                    print(ViewGeometry.width)
//                    print()
//                    extraDrag = 2*(drag.location.x/ViewGeometry.width-0.5)
//                }
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
