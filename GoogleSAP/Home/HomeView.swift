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
    let SMALL_PROGRESS_VIEW_PADDING = CGFloat(16)
    
    @ObservedObject var loggerHistoryManager = LoggerDataManager()
    
    @State var progress = 0.0;
    
    @State var TwoPointFourKMRunHighestScore = 641.0
    @State var ShuttleRunHighestScore = 10.2
    @State var SitUpsHighestScore = 42.0
    @State var SitAndReachHighestScore = 45.0
    @State var InclinedPullupsHighestScore = 7.0
    @State var StandingBroadJumpHighestScore = 237.0
    
    
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
    
    @State var heightOfNavView = 0.0
    
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
                        
                        
                        
//                        CustomScrollView(sizeOfProgBar: $heightOfNavView)
//                            .frame(height: heightOfNavView)
                        
                        
                        Form {
                            Text("helo wolrd")
                        }
                        .padding(.top, sizeOfBigProgress * 0.00)
                        
                    }.navigationTitle("Overview")
                        .navigationBarTitleDisplayMode(.inline)
                }
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


//struct CustomScrollView: View {
//    @Environment(\.colorScheme) var colorScheme
//
//    @State var selectedRing = 0
//    @State var geometry = CGSize(width: 0.0, height: 0.0)
//
//    @Binding var sizeOfProgBar: Double
//
//    var body: some View {
//        ZStack(alignment: .center) {
//            GeometryReader {geo in
//                HStack {
//
//                }.onAppear {
//                    geometry = geo.size
//                }
//            }
//
//            ZStack {
//                Rectangle()
//                    .fill(colorScheme == .dark ? .white : .black)
//                    .frame(width: geometry.width, height: geometry.width / 8)
//                HStack {
//                    CustomProgressView(geometry: geometry, Selection: $selectedRing, index: 0)
//
//                    Spacer()
//
//                    CustomProgressView(geometry: geometry, Selection: $selectedRing, index: 1)
//
//                    Spacer()
//
//                    CustomProgressView(geometry: geometry, Selection: $selectedRing, index: 2)
//
//                }.frame(width: geometry.width / 2.5, height: geometry.width / 11)
//            }
//            .background {
//                GeometryReader { geometryProxy in
//                    Color.clear
//                        .onAppear {
//                            sizeOfProgBar = geometryProxy.size.height
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct CustomProgressView: View {
//    @Environment(\.colorScheme) var colorScheme
//    var geometry: CGSize
//    @Binding var Selection: Int
//    var index: Int
//
//    var body: some View {
//        ZStack(alignment:.center) {
//            Circle()
//                .fill(Selection == index ? colorScheme == .dark ? .black : .white : .clear)
//                .frame(width: geometry.width / 17, height: geometry.width / 17)
//            Circle()
//                .stroke(
//                    Color.red.opacity(0.7),
//                    lineWidth: CGFloat(10)
//                )
//
//            Circle() // 2
//                .trim(from: 0, to: 0.25)
//                .stroke(
//                    Color.green,
//                    // 1
//                    style: StrokeStyle(
//                        lineWidth: CGFloat(10),
//                        lineCap: .round
//                    )
//                )
//                .rotationEffect(.degrees(-90))
//                .animation(.easeOut, value: 0.25)
//        }
//        .frame(width: geometry.width / 18, height: geometry.width / 18)
//        .onTapGesture {
//            withAnimation {
//                Selection = index
//            }
//
//        }
//    }
//}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//struct CustomScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack(alignment: .center) {
//            Spacer()
//            CustomScrollView(sizeOfProgBar: )
//        }
//    }
//}

//
//HStack {
//    Spacer()
//
//    ForEach(secondRow, id: \.self) { theLists in
//        CircularProgressViewSmall(progress: 0) {
//            CircularProgressViewSmall(progress: theLists.fraction) {
//                Text(theLists.text).multilineTextAlignment(.center)
//            }
//            .padding(SMALL_PROGRESS_VIEW_PADDING)
//        }
//        .frame(width: geometry.size.width/3-25, height: geometry.size.width/3-25)
//        Spacer()
//    }
//}
//.padding(.leading, 3)
//.padding(.trailing, 3)
//.padding(.top, 20)
//
//HStack {
//    Spacer()
//
//    ForEach(thirdRow, id: \.self) { text in
//        CircularProgressViewSmall(progress: 0.0) {
//            CircularProgressViewSmall(progress: text.fraction) {
//                Text(text.text)
//                    .multilineTextAlignment(.center)
//            }
//            .padding(SMALL_PROGRESS_VIEW_PADDING)
//        }
//        .frame(width: geometry.size.width/3-15, height: geometry.size.width/3-15)
//        Spacer()
//    }
//}
//.padding(.leading, 3)
//.padding(.trailing, 3)
//.padding(.top, 10)
