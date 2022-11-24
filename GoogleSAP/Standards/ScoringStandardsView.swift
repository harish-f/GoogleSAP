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
    
    var body: some View {
        ZStack {
            GeometryReader{ geometry in
                Spacer().onAppear { ViewGeometry = geometry.size }
            }
            let stations = Stations[ageInput<=18 ? "NAPFA":"IPPT"]!
            VStack {
                let ageGroup = Int(ceil( Double(ageInput)/3 - 6.0 ))
                Text(ageInput<=18 ? "NAPFA":"IPPT").font(.title).bold()
                if ageInput<=18 {
                    Text("")
                } else {
                    Text("Age Group: \(ageGroup)")
                }
                Spacer()
            }
            Group {
                GeometryReader{ geometry in
                    Circle()
                        .fill(Color(UIColor.label))
                        .frame(width: ViewGeometry.width*1.5, height: ViewGeometry.height*1.5)
                        .scaleEffect(circlePickerScale)
                        .offset(x: 0-ViewGeometry.width/4, y: ViewGeometry.height/2-ViewGeometry.height/50)
                        .onAppear{ withAnimation{ circlePickerScale = 1.0 } }
                }
                let countOffset = 360.0/Double(stations.count)
                ForEach(stations, id: \.self) {
                    Text($0.name)
                        .bold()
                        .foregroundColor(Color(UIColor.secondarySystemBackground))
                        .multilineTextAlignment(.center)
                        .frame(width: ViewGeometry.width/5)
                        .padding(.bottom, ViewGeometry.width)
                        .rotationEffect(Angle(
                            degrees: countOffset*Double(stations.firstIndex(of: $0)!) - countOffset*Double(scrollSelected)
                        ))
                        .offset(y: (ViewGeometry.height/2-ViewGeometry.height/50)*1.5)
                }
            }.gesture(DragGesture()
                .onEnded { drag in
                    var ref = 0
                    if drag.translation.width>0 { ref = -1 }
                    else if drag.translation.width<0 { ref = 1 }
                    let stationsCount = Stations[ageInput<18 ? "NAPFA":"IPPT"]!.count
                    var ref2 = ref
                    if selected+ref<0 { ref2 += stationsCount }
                    if selected+ref>=stationsCount { ref2 -= stationsCount }
                    withAnimation(.spring(response: 0.125, dampingFraction: 0.5)) {
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
