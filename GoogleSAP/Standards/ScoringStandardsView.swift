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
    
    @State var ageInput: Int
    
    @State var selected: Int = 1
    
    var body: some View {
        ZStack {
            GeometryReader{ geometry in
                Spacer().onAppear { ViewGeometry = geometry.size }
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
                let stations = Stations[ageInput<18 ? "NAPFA":"IPPT"]!
                let countOffset = 360.0/Double(Stations[ageInput<18 ? "NAPFA":"IPPT"]!.count)
                ForEach(stations, id: \.self) {
                    Text($0.name)
                        .bold()
                        .foregroundColor(Color(UIColor.secondarySystemBackground))
                        .multilineTextAlignment(.center)
                        .frame(width: ViewGeometry.width/5)
                        .padding(.bottom, ViewGeometry.width)
                        .rotationEffect(Angle(
                            degrees: countOffset*Double(stations.firstIndex(of: $0)!) + countOffset*Double(selected)
                        ))
                        .offset(y: (ViewGeometry.height/2-ViewGeometry.height/50)*1.5)
                }
            }.gesture(DragGesture()
                .onEnded { drag in
                    withAnimation(.spring(response: 0.25, dampingFraction: 0.5)) {
                        selected += drag.translation.width>0 ? 1:-1
                    }
                })
        }
    }
}

struct ScoringStandardsView_Previews: PreviewProvider {
    static var previews: some View {
        ScoringStandardsView(ageInput: 14)
    }
}
