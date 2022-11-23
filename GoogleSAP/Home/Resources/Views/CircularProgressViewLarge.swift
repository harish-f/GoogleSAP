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
    let sfSymbolNameTop: String
    let sfSymbolNameBottom: String
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
                Image(systemName: sfSymbolNameTop)
                    .font(.title2)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(-13)
            VStack {
                Spacer()
                Image(systemName: sfSymbolNameBottom)
                    .font(.title2)
                    .foregroundColor(.white)
            }
            .padding(-13)
        }
    }
}

//extension CircularProgressViewLargeIcon where Content == EmptyView {
//    init(progress: Double, symbolTop: String, symbolBottom: String) {
//        self.init(progress: progress, sfSymbolNameTop: symbolTop, sfSymbolNameBottom: symbolBottom, content: { EmptyView() })
//  }
//}



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

struct CircularProgressViewLargeIcon_Previews: PreviewProvider {
    struct SimpleView: View {
        var body: some View {
            VStack {
                Text("SimpleView Text")
            }
        }
    }
    static var previews: some View {
        CircularProgressViewLargeIcon(progress: 0.25, sfSymbolNameTop: "arrow.right", sfSymbolNameBottom: "questionmark.circle", content: {
            SimpleView()
        })
            .frame(width:200, height: 200)
        
//        CircularProgressViewLargeIcon<<#Content: View#>>(progress: 0.25, symbolTop: "arrow.right", symbolBottom: "")
//            .frame(width:200, height: 200)
    }
}

