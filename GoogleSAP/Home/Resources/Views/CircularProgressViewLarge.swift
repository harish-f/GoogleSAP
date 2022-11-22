//
//  CircularProgressView.swift
//  GoogleSAP
//
//  Created by Sairam Suresh on 13/10/22.
//

import SwiftUI

struct CircularProgressViewLarge<Content: View>: View {
    let progress: Double
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
            ZStack {
                content
                Circle()
                    .stroke(
                        Color.red.opacity(0.7),
                        lineWidth: CGFloat(30)
                    )
                Circle() // 2
                    .trim(from: 0, to: progress)
                    .stroke(
                        Color.green,
                        // 1
                        style: StrokeStyle(
                            lineWidth: CGFloat(30),
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: progress)
            }
            VStack {
                Image(systemName: "arrow.right")
                    .font(.title)
                Spacer()
            }
            .padding(-12)
        }
    }
}

extension CircularProgressViewLarge where Content == EmptyView {
    init(progress: Double) {
      self.init(progress: progress, content: { EmptyView() })
  }
}


struct CircularProgressViewLargeIcon<Content: View>: View {
    let progress: Double
    let sfSymbolName: String
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
            ZStack {
                content
                Circle()
                    .stroke(
                        Color.red.opacity(0.7),
                        lineWidth: CGFloat(30)
                    )
                Circle() // 2
                    .trim(from: 0, to: progress)
                    .stroke(
                        Color.green,
                        // 1
                        style: StrokeStyle(
                            lineWidth: CGFloat(30),
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: progress)
            }
            VStack {
                Image(systemName: sfSymbolName)
                    .font(.title2)
                    .foregroundColor(.black)
                Spacer()
            }
            .padding(-12)
        }
    }
}

extension CircularProgressViewLargeIcon where Content == EmptyView {
    init(progress: Double, symbol: String) {
        self.init(progress: progress, sfSymbolName: symbol, content: { EmptyView() })
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
        CircularProgressViewLarge(progress: 0.25, content: {
            SimpleView()
        })
            .frame(width:200, height: 200)
        
        CircularProgressViewLarge(progress: 0.25)
            .frame(width:200, height: 200)
    }
}
