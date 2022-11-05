//
//  InternalProgressDataLargeView.swift
//  GoogleSAP
//
//  Created by Sairam Suresh on 22/10/22.
//

import SwiftUI

struct InternalProgressDataLargeView: View {
    let name: _Stations
    var body: some View {
        VStack {
            Text("hello world")
                .font(.title)
        
            
            HStack {
                Text("Deez nuts")
                Image(systemName: "arrow.up")
            }
        }
    }
}

struct InternalProgressDataLargeView_Previews: PreviewProvider {
    static var previews: some View {
        InternalProgressDataLargeView(name: .SitUps)
    }
}
