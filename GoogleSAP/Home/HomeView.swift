//
//  HomeView.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 12/10/22.
//

import SwiftUI

struct HomeView: View {
    @State var progress = 0.0
    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) {
//              TODO: Make the ProgressViews data dependent on internal storage
                VStack(alignment: .leading) {
                    CircularProgressView(progress:progress, content: {
                        CircularProgressView(progress: progress, content: {
                            Button {
                                progress += 0.1
                            } label: {
                                Text("Press me")
                            }
                        })
                            .frame(width:UIScreen.main.bounds.width-150, height: UIScreen.main.bounds.width-50)
                    })
                        .frame(width:UIScreen.main.bounds.width-50, height: UIScreen.main.bounds.width-50)
                        .padding(20)
                    HStack {
                        
                    }
                    Spacer()
                }
                .navigationTitle("Overview")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
