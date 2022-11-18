//
//  CircleProgressBar.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 16/11/22.
//

import SwiftUI

struct CircleProgressBar: View {
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    let totalTime: Double
    let showReps: Bool
    @State var timeRemaining: Double
    @State var repInfo: String
    var body: some View {
        ZStack {
            if showReps {
                Text(repInfo)
            } else {
                Text("\(String(format: "%.1f", timeRemaining))")
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
        .onReceive(timer) { _ in
            withAnimation {
                timeRemaining -= 0.1
            }
            if timeRemaining < 0 {
                timeRemaining = totalTime
            }
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
