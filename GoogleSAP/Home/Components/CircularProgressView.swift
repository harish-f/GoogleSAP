//
//  CircularProgressView.swift
//  GoogleSAP
//
//  Created by Sairam Suresh on 13/10/22.
//

import SwiftUI

struct CircularProgressView<Content: View>: View {
    let progress: Double
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
            content
            Circle()
                .stroke(
                    Color.pink.opacity(0.5),
                    lineWidth: 30
                )
            Circle() // 2
                .trim(from: 0, to: progress)
                .stroke(
                    Color.pink,
                    // 1
                    style: StrokeStyle(
                        lineWidth: 30,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
        }
    }
}

extension CircularProgressView where Content == EmptyView {
  init(progress: Double) {
      self.init(progress: progress, content: { EmptyView() })
  }
}


struct CircularProgressView_Previews: PreviewProvider {
    struct SimpleView: View {
        var body: some View {
            VStack {
                Text("SimpleView Text")
            }
        }
    }
    static var previews: some View {
        CircularProgressView(progress: 0.25, content: {
            SimpleView()
        })
            .frame(width:200, height: 200)
        
        CircularProgressView(progress: 0.25)
            .frame(width:200, height: 200)
    }
}
