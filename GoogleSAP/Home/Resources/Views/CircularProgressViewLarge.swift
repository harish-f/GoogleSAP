//
//  CircularProgressView.swift
//  GoogleSAP
//
//  Created by Sairam Suresh on 13/10/22.
//

import SwiftUI

struct CircularProgressViewLarge<Content: View>: View {
    let progress: Double
    @Binding var refresh: Int
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
    init(progress: Double, refresh: Binding<Int>) {
        self.init(progress: progress, refresh: refresh, content: { EmptyView() })
  }
}


struct CircularProgressViewLargeIcon<Content: View>: View {
    let progress: Double
    @Binding var refresh: Int
    let screenGeo: CGSize
    let sfSymbolNameTop: String
    let sfSymbolNameBottom: String
    @Environment(\.colorScheme) var colorScheme
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
            ZStack {
                content
                Circle()
                    .stroke(
                        colorScheme == .dark ? Color.gray.opacity(0.7) : Color.gray.opacity(0.3),
                        lineWidth: CGFloat(screenGeo.width / 14)
                    )
                Circle() // 2
                    .trim(from: 0, to: progress)
                    .stroke(
                        Color.green,
                        // 1
                        style: StrokeStyle(
                            lineWidth: CGFloat(screenGeo.width / 14),
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(Double(refresh - refresh - 93)))
                    .animation(.easeOut, value: progress)
            }
            VStack {
                if sfSymbolNameTop != "" {
                    Image(systemName: sfSymbolNameTop)
                        .font(.title2)
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding(-13)
            VStack {
                Spacer()
                if sfSymbolNameBottom != "" {
                    Image(systemName: sfSymbolNameBottom)
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            .padding(-13)
        }
        .onAppear {
            print("refres")
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
    
    @State static var num = 0
    static var previews: some View {
        CircularProgressViewLarge(progress: 0.25, refresh: $num, content: {
            SimpleView()
        })
            .frame(width:200, height: 200)
        
        CircularProgressViewLarge(progress: 0.25, refresh: $num)
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
    
    static var someSize = CGSize(width: 300, height: 300)
    @State static var a = 1
    
    static var previews: some View {
        CircularProgressViewLargeIcon(progress: 0.25, refresh: $a, screenGeo: someSize, sfSymbolNameTop: "arrow.right", sfSymbolNameBottom: "questionmark.circle", content: {
            SimpleView()
        })
            .frame(width:200, height: 200)
        
//        CircularProgressViewLargeIcon<<#Content: View#>>(progress: 0.25, symbolTop: "arrow.right", symbolBottom: "")
//            .frame(width:200, height: 200)
    }
}

