//
//  LoggerMenuItem.swift
//  GoogleSAP
//
//  Created by Sairam Suresh on 13/11/22.
//

import SwiftUI

struct LoggerMenuItem: View {
    let date: Date
    let description: String
    
    
    var body: some View {
        HStack {
            VStack(alignment: HorizontalAlignment.leading) {
                Text(date.formatted(date: .abbreviated, time: .omitted))
                    .font(.system(.title3))
                Text(description)
                    .font(.system(.subheadline))
            }
        }
    }
}

struct LoggerMenuItem_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            LoggerMenuItem(date:Date(timeIntervalSinceNow: .zero), description: "sup my top g")
        }
    }
}
