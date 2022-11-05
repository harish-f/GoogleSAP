//
//  CircularProgressView.swift
//  GoogleSAP
//
//  Created by Sairam Suresh on 13/10/22.
//

import SwiftUI

struct CircularProgressViewSmall<Content: View>: View {
    let progress: Double
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
            content
            Circle()
                .stroke(
                    Color.red.opacity(0.5),
                    lineWidth: CGFloat(10)
                )
            Circle() // 2
                .trim(from: 0, to: progress)
                .stroke(
                    Color.green,
                    // 1
                    style: StrokeStyle(
                        lineWidth: CGFloat(10),
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
        }
    }
}

extension CircularProgressViewSmall where Content == EmptyView {
    init(progress: Double) {
      self.init(progress: progress, content: { EmptyView() })
  }
}


struct CircularProgressViewSmall_Previews: PreviewProvider {
    struct SimpleView: View {
        var body: some View {
            VStack {
                Text("SimpleView Text")
            }
        }
    }
    static var previews: some View {
        CircularProgressViewSmall(progress: 0.25, content: {
            SimpleView()
        })
            .frame(width:200, height: 200)
        
        CircularProgressViewSmall(progress: 0.25)
            .frame(width:200, height: 200)
    }
}
