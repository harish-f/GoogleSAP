//
//  CircleProgressBar.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 16/11/22.
//

import SwiftUI

struct CircleProgressBar: View {
    let totalTime: Double
    let showReps: Bool
    @Binding var timeRemaining: Double
    @Binding var repInfo: String
    var body: some View {
        ZStack {
            if showReps {
                Text(repInfo)
            } else {
                Text("\(String(format: "%.0f", timeRemaining))")
                    .animation(.none)
            }
            Circle()
                .stroke(.green, lineWidth: 10)
                .opacity(0.3)
                .frame(width: 100)
            Circle()
                .trim(from: 0, to: timeRemaining/totalTime)
                .stroke(.green, style: StrokeStyle(
                    lineWidth: 10,
                    lineCap: .round
                )
                )
                .frame(width: 100)
                .rotationEffect(.degrees(-90))
        }
    }
}

struct CircleProgressBar_Previews: PreviewProvider {
    //    static
    static var previews: some View {
        VStack{
//            CircleProgressBar()
        }
    }
}
