//
//  HomeView.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 12/10/22.
//

import SwiftUI



struct HomeView: View {
    let SMALL_PROGRESS_VIEW_SIZE = UIScreen.main.bounds.width-307
    let SMALL_PROGRESS_VIEW_PADDING = CGFloat(16)
    
    @State var progress = 0.0;
    @StateObject var homeManager = HomeDataManager()

    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack(alignment: .leading) {
                    // TODO: Make the ProgressViews data dependent on internal storage
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            CircularProgressViewLarge(progress:progress, content: {
                                CircularProgressViewLarge(progress: progress, content: {
                                    
                                })
                                .padding(.leading, 45)
                                .padding(.trailing, 45)
                            })
                            .frame(width:UIScreen.main.bounds.width-50, height: UIScreen.main.bounds.width-50)
                            Spacer()
                        }
                        .padding(.top, 10)
                        
                        
                        
                        
                        // TODO: make this adapt to different screen sizes
                        HStack {
                            Spacer()
                            
                            ForEach(0...2, id: \.self) { _ in
                                CircularProgressViewSmall(progress: 0.25) {
                                    CircularProgressViewSmall(progress: 0.25)
                                        .padding(SMALL_PROGRESS_VIEW_PADDING)
                                }
                                .frame(width: geometry.size.width/3-20, height: geometry.size.width/3-20)
                                Spacer()
                            }
                        }
                        .padding(.leading, 3)
                        .padding(.trailing, 3)
                        .padding(.top, 20)
                        
                        HStack {
                            Spacer()
                            
                            ForEach(0...1, id: \.self) { _ in
                                CircularProgressViewSmall(progress: 0.25) {
                                    CircularProgressViewSmall(progress: 0.25)
                                        .padding(SMALL_PROGRESS_VIEW_PADDING)
                                }
                                .frame(width: geometry.size.width/3-5, height: geometry.size.width/3-5)
                                Spacer()
                            }
                        }
                        .padding(.leading, 3)
                        .padding(.trailing, 3)
                        .padding(.top, 20)
                        
                        Spacer()
                        
                        
                    }.navigationTitle("Overview")
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
