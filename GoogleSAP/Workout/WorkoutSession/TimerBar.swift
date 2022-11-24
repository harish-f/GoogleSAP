//
//  TimerBar.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 5/11/22.
//

import SwiftUI

struct TimerBar: View {
    let totalTime: Double
    @Binding var timeRemaining: Double
    var body: some View {
        ZStack(alignment: .leading) {
            VStack{}
                .frame(width: CGFloat(Double(timeRemaining)/Double(totalTime))*UIScreen.main.bounds.size.width)
                .frame(height: 20)
                .background(.green)
            HStack {
                Text("\(String(format: "%.0f", timeRemaining))")
                    .padding(.leading)
                Spacer()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(.red)
    }
}

struct TimerBar_Previews: PreviewProvider {
    static var previews: some View {
        TimerBar(totalTime: 10, timeRemaining: .constant(10))
    }
}
