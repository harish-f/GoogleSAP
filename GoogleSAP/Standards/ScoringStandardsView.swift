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
    
    let ABCDE = ["A", "B", "C", "D", "E"]
    
    var body: some View {
        ZStack {
            GeometryReader{ geometry in
                Spacer().onAppear { ViewGeometry = geometry.size }
            }
            Color(UIColor.systemBackground)
            let stations = genderInput == .male && ageInput >= 15 ? Stations[ageInput<=19 ? "NAPFA":"IPPT"]!.map{ $0.name == "No. of Inclined Pull-ups in 30 sec" ? Workout(name: "No. of Pull-ups in 30 sec", range: 0...10, isInt: true):$0 }:Stations[ageInput<=19 ? "NAPFA":"IPPT"]! //updated for napfa only
            VStack {
                let ageGroup = Int(ceil( Double(ageInput)/3 - 6.0 ))
                Text(ageInput<=19 ? "NAPFA":"IPPT").font(.title).bold()//updated for napfa only
                if ageInput<=19 {//updated for napfa only
                    Text("")
                } else {
                    Text("Age Group: \(ageGroup)")
                }
                Group {
                    ForEach(0...ABCDE.count-1, id: \.self) { i in
                        HStack {
                            Spacer()
                            Text(ABCDE[i])
                            Text(String(ABCDE.count-i))
                            Spacer()
                            Text("")
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
                    Text($0.name)
                        .bold(stations[selected].name == $0.name)
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
                    let stationsCount = Stations[ageInput<=19 ? "NAPFA":"IPPT"]!.count//updated for napfa only
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
