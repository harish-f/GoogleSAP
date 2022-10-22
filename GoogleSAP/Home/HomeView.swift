//
//  HomeView.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 12/10/22.
//

import SwiftUI



struct HomeView: View {
    let LineThicknessBiggest = 25;
    let LineThicknessSmaller = 9;
    @State var progress = 0.0;
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) {
                //              TODO: Make the ProgressViews data dependent on internal storage
                VStack(alignment: .leading) {
                    CircularProgressViewLarge(progress:progress, lineWidth:LineThicknessBiggest, content: {
                        CircularProgressViewLarge(progress: progress, lineWidth:LineThicknessBiggest, content: {
                            Button {
                                progress += 0.1
                            } label: {
                                Text("Press me")
                            }
                        })
                        .padding(.leading, 45)
                        .padding(.trailing, 45)
                    })
                    .frame(width:UIScreen.main.bounds.width-50, height: UIScreen.main.bounds.width-50)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                }.navigationTitle("Overview")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
