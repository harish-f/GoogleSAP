//
//  HomeView.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 12/10/22.
//

import SwiftUI
import SwiftUISnappingScrollView


struct ProgressData: Hashable, Identifiable {
    var text: String
    var fractionNAPFA: Double
    var fractionWorkout: Double
    var id = UUID()
}


//  - Replace Text with symbols
//  - Fix wrapping text issues
//  - Add symbols to the start of the rings
//  - The rings might be too close to the edge
//  - Switch the weird picker thing for a textfield
//  - Colour Scheme
//  -

struct idGen: Hashable {
    var text: String
}


struct HomeView: View {
    @ObservedObject var loggerHistoryManager = LoggerDataManager()
    
    @State var TwoPointFourKMRunHighestScore = 641.0
    @State var ShuttleRunHighestScore = 10.2
    @State var SitUpsHighestScore = 42.0
    @State var SitAndReachHighestScore = 45.0
    @State var InclinedPullupsHighestScore = 7.0
    @State var StandingBroadJumpHighestScore = 237.0
    
    // TODO: MAKE THIS TAKE FROM PERSISTENCE AND AUTOUPDATE BASED ON BDAY
    @State var age = 16
    
    
    // Data in here is just placeholder (variable data declared in view .onAppear)
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
    
    @State var lastWorkoutElement: LogRecord = LogRecord(
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
    
    // Data in here is just placeholder (variable data declared in view .onAppear)
    @State var data: [ProgressData] = []
    
    @State var sizeOfBigProgress = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack(alignment: .leading) {
                    // TODO: MAKE VIEWS ADAPT TO USER AGE
                    
                    VStack(alignment: .leading) {
                        
                        
                        ScrollViewReader { proxy in
                            SnappingScrollView(.horizontal, decelerationRate: .fast, showsIndicators: true) {
                                ForEach(data) { datum in
                                    Spacer()
                                    HStack(alignment: .center) {
                                        VStack(alignment: .center) {
                                            CircularProgressViewLarge(progress: datum.fractionWorkout, content: {
                                                CircularProgressViewLarge(progress: datum.fractionNAPFA, content: {
                                                    Button {
                                                        proxy.scrollTo(idGen(text: datum.text))
                                                    } label: {
                                                        Text(datum.text).font(.title3)
                                                    }
                                                })
                                                .padding(.leading, 45)
                                                .padding(.trailing, 45)
                                            })
                                            .frame(width:UIScreen.main.bounds.width-50, height: UIScreen.main.bounds.width-50, alignment: .center)
                                            .padding(.bottom, geometry.size.height * 0.03)
                                        }
                                    }
                                    .padding(.top, 10)
                                    .padding()
                                    .background(
                                        GeometryReader { geometryProxy in
                                            Color.clear
                                                .onAppear {
                                                    sizeOfBigProgress = geometryProxy.size.height
                                                }
                                        }
                                    )
                                    
                                    Spacer()
                                        .scrollSnappingAnchor(.bounds)
                                        .id(idGen(text: datum.text))
                                }
                                
                            }
                            .padding(.bottom, sizeOfBigProgress * 0.000)
                        }
                        
                        
                        Form {
                            Text("helo wolrd")
                        }
                        .padding(.top, sizeOfBigProgress * 0.00)
                        
                    }.navigationTitle("Overview")
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarItems(trailing:Stepper(value: $age, in: 0...20) {Text("")})
                        .navigationBarItems(leading:Text("Age: " + String(age)))
                }.onAppear {
                    loggerHistoryManager.loadData()
                    
                    lastNAPFAElement = loggerHistoryManager.logRecords.last { LogRecord in
                        LogRecord.napfaOrWorkout == "Napfa"
                    } ?? LogRecord(
                        NapfaOrWorkouts: .napfa,
                        description: "This is my description",
                        date: Date(timeInterval: .zero, since: .now),
                        twoPointFourKMRun: "0",
                        shuttleRun: "0",
                        sitUps: "0",
                        sitAndReach: "0",
                        inclinedPullups: "0",
                        standingBroadJump: "0"
                    )
                    
                    lastWorkoutElement = loggerHistoryManager.logRecords.last { LogRecord in
                        LogRecord.NapfaOrWorkouts == .workout
                    } ?? LogRecord(
                        NapfaOrWorkouts: .workout,
                        description: "This is my description",
                        date: Date(timeInterval: .zero, since: .now),
                        twoPointFourKMRun: "0",
                        shuttleRun: "0",
                        sitUps: "0",
                        sitAndReach: "0",
                        inclinedPullups: "0",
                        standingBroadJump: "0"
                    )
                    
                    data = [
                        ProgressData(text: "2.4 Run",
                                     fractionNAPFA: TwoPointFourKMRunHighestScore / Double(lastNAPFAElement.twoPointFourKMRun)!,
                                     fractionWorkout: TwoPointFourKMRunHighestScore / Double(lastWorkoutElement.twoPointFourKMRun)!),
                        ProgressData(text: "Situps",
                                     fractionNAPFA: Double(lastNAPFAElement.sitUps)! / SitUpsHighestScore, fractionWorkout: Double(lastWorkoutElement.sitUps)! / SitUpsHighestScore),
                        ProgressData(text: "Inclined Pullups",
                                     fractionNAPFA: Double(lastNAPFAElement.inclinedPullups)! / StandingBroadJumpHighestScore,
                                     fractionWorkout: Double(lastWorkoutElement.inclinedPullups)! / StandingBroadJumpHighestScore),
                        ProgressData(text: "Sit & Reach",
                                     fractionNAPFA: Double(lastNAPFAElement.sitAndReach)! / SitAndReachHighestScore,
                                     fractionWorkout: Double(lastWorkoutElement.sitAndReach)! / SitAndReachHighestScore),
                        ProgressData(text: "Shuttle Run",
                                     fractionNAPFA: ShuttleRunHighestScore / Double(lastNAPFAElement.shuttleRun)!,
                                     fractionWorkout: ShuttleRunHighestScore / Double(lastWorkoutElement.shuttleRun)!),
                        ProgressData(text: "Standing Broad Jump",
                                     fractionNAPFA: Double(lastNAPFAElement.standingBroadJump)! / StandingBroadJumpHighestScore, fractionWorkout: Double(lastWorkoutElement.standingBroadJump)! / StandingBroadJumpHighestScore)
                    ]
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
