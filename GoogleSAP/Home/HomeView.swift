//
//  HomeView.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 12/10/22.
//

import SwiftUI


struct ProgressData: Hashable {
    var text: String
    var fraction: Double
}


struct HomeView: View {
    let SMALL_PROGRESS_VIEW_PADDING = CGFloat(16)
    
    @ObservedObject var loggerHistoryManager = LoggerDataManager()
    
    @State var progress = 0.0;
    @StateObject var homeManager = HomeDataManager()
    @State var lastNAPFAElement: LogRecord = LogRecord(
        NapfaOrWorkouts: .napfa,
        description: "This is my description",
        date: Date(timeInterval: .zero, since: .now),
        twoPointFourKMRun: "0.1",
        shuttleRun: "0.2",
        sitUps: "0.3",
        sitAndReach: "0.4",
        inclinedPullups: "0.5",
        standingBroadJump: "0.6"
    )
    @State var secondRow: [ProgressData] = [
        ProgressData(text: "2.4 Run", fraction: 0.0),
        ProgressData(text: "Situps", fraction: 0.0),
        ProgressData(text: "Inclined Pullups",fraction: 0.0),
    ]
    @State var thirdRow: [ProgressData] = [
        ProgressData(text: "Sit & Reach", fraction: 0.0),
        ProgressData(text: "Shuttle Run", fraction: 0.0),
    ]
    
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack(alignment: .leading) {
                    // TODO: MAKE VIEWS ADAPT TO USER AGE
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            CircularProgressViewLarge(progress: progress, content: {
                                CircularProgressViewLarge(progress: Double(lastNAPFAElement.standingBroadJump)! / 237, content: {
                                    Text("Standing Broad Jump").font(.title2)
                                })
                                .padding(.leading, 45)
                                .padding(.trailing, 45)
                            })
                            .frame(width:UIScreen.main.bounds.width-50, height: UIScreen.main.bounds.width-50)
                            Spacer()
                        }
                        .padding(.top, 10)
                        
                        
                        HStack {
                            Spacer()
                            
                            ForEach(secondRow, id: \.self) { theLists in
                                CircularProgressViewSmall(progress: 0) {
                                    CircularProgressViewSmall(progress: theLists.fraction) {
                                        Text(theLists.text).multilineTextAlignment(.center)
                                    }
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
                            
                            ForEach(thirdRow, id: \.self) { text in
                                CircularProgressViewSmall(progress: 0.0) {
                                    CircularProgressViewSmall(progress: text.fraction) {
                                        Text(text.text).multilineTextAlignment(.center)
                                    }
                                    .padding(SMALL_PROGRESS_VIEW_PADDING)
                                }
                                .frame(width: geometry.size.width/3-10, height: geometry.size.width/3-10)
                                Spacer()
                            }
                        }
                        .padding(.leading, 3)
                        .padding(.trailing, 3)
                        .padding(.top, 20)
                        
                        Spacer()
                        
                        
                    }.navigationTitle("Overview")
                }
            }.onAppear {
                lastNAPFAElement = loggerHistoryManager.logRecords.last { LogRecord in
                    LogRecord.napfaOrWorkout == "Napfa"
                }!
                print(lastNAPFAElement)
                
                secondRow = [
                    ProgressData(text: "2.4 Run", fraction: Double(lastNAPFAElement.twoPointFourKMRun)! / 237),
                    ProgressData(text: "Situps", fraction: Double(lastNAPFAElement.sitUps)! / 42),
                    ProgressData(text: "Inclined Pullups", fraction: Double(lastNAPFAElement.standingBroadJump)! / 7),
                ]
                
                print(secondRow[2])
                
                thirdRow = [
                    ProgressData(text: "Sit & Reach", fraction: Double(lastNAPFAElement.sitAndReach)! / 45),
                    ProgressData(text: "Shuttle Run", fraction: 10 / Double(lastNAPFAElement.shuttleRun)!),
                ]
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
