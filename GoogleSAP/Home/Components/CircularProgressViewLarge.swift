//
//  CircularProgressView.swift
//  GoogleSAP
//
//  Created by Sairam Suresh on 13/10/22.
//

import SwiftUI

struct CircularProgressViewLarge<Content: View>: View {
    let progress: Double
    let lineWidth: Int
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
            content
            Circle()
                .stroke(
                    Color.red.opacity(0.5),
                    lineWidth: CGFloat(lineWidth)
                )
            Circle() // 2
                .trim(from: 0, to: progress)
                .stroke(
                    Color.green,
                    // 1
                    style: StrokeStyle(
                        lineWidth: CGFloat(lineWidth),
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
        }
    }
}

extension CircularProgressViewLarge where Content == EmptyView {
    init(progress: Double, lineWidth: Int) {
      self.init(progress: progress, lineWidth: lineWidth, content: { EmptyView() })
  }
}


struct CircularProgressViewLarge_Previews: PreviewProvider {
    struct SimpleView: View {
        var body: some View {
            VStack {
                Text("SimpleView Text")
            }
        }
    }
    static var previews: some View {
        CircularProgressViewLarge(progress: 0.25, lineWidth:30, content: {
            SimpleView()
        })
            .frame(width:200, height: 200)
        
        CircularProgressViewLarge(progress: 0.25, lineWidth:30)
            .frame(width:200, height: 200)
    }
}
