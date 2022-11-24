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
    var fractionWorkoutForA: Double
    var fractionWorkoutForUserGoal: Double
    var id = UUID()
}


//  - Replace Text with symbols
//  - Switch the weird picker thing for a textfield
//  - Colour Scheme


// TODO: FIGURE OUT A WAY TO GET HOMESCREEN TO RERENDER AFTER MODAL VIEW IS REMOVED FROM SCREEN
// TODO: PUT DOWN ALL VALUES FROM NAPFA INTO TABLE VIEW TO SHOW NAPFA A SCORE DIFFS

struct idGen: Hashable {
    var text: String
}

struct NAPFAAScores {
    var age: Int
    var TwoPointFourKMRunUserSetScoreMale: Double
    var ShuttleRunUserSetScoreMale: Double
    var SitUpsUserSetScoreMale: Double
    var SitAndReachUserSetScoreMale: Double
    var InclinedPullupsUserSetScoreMale: Double
    var StandingBroadJumpUserSetScoreMale: Double
    
    var TwoPointFourKMRunUserSetScoreFemale: Double
    var ShuttleRunUserSetScoreFemale: Double
    var SitUpsUserSetScoreFemale: Double
    var SitAndReachUserSetScoreFemale: Double
    var InclinedPullupsUserSetScoreFemale: Double
    var StandingBroadJumpUserSetScoreFemale: Double
}



struct HomeView: View {
    @Binding var tabSelection: Int
    
    @ObservedObject var loggerHistoryManager = LoggerDataManager()
    
    @State var stillHaveUnsetGoals = false
    @State var stillNeedFillNAPFAEntry = false
    @State var stillNeedFillWorkoutEntry = false
    
    @State var listOfNapfaScores = [
        NAPFAAScores(age: 9,
            TwoPointFourKMRunUserSetScoreMale: 580.0,
            ShuttleRunUserSetScoreMale: 11.3,
            SitUpsUserSetScoreMale: 35.0,
            SitAndReachUserSetScoreMale: 33.0,
            InclinedPullupsUserSetScoreMale: 21.0,
            StandingBroadJumpUserSetScoreMale: 168.0,
                     
            TwoPointFourKMRunUserSetScoreFemale: 640.0,
            ShuttleRunUserSetScoreFemale: 11.8,
            SitUpsUserSetScoreFemale: 26.0,
            SitAndReachUserSetScoreFemale: 37.0,
            InclinedPullupsUserSetScoreFemale: 22.0,
            StandingBroadJumpUserSetScoreFemale: 158.0
        ),
        
        NAPFAAScores(age: 10,
            TwoPointFourKMRunUserSetScoreMale: 570.0,
            ShuttleRunUserSetScoreMale: 11.1,
            SitUpsUserSetScoreMale: 36.0,
            SitAndReachUserSetScoreMale: 35.0,
            InclinedPullupsUserSetScoreMale: 22.0,
            StandingBroadJumpUserSetScoreMale: 174.0,
                     
            TwoPointFourKMRunUserSetScoreFemale: 630.0,
            ShuttleRunUserSetScoreFemale: 11.7,
            SitUpsUserSetScoreFemale: 27.0,
            SitAndReachUserSetScoreFemale: 39.0,
            InclinedPullupsUserSetScoreFemale: 21.0,
            StandingBroadJumpUserSetScoreFemale: 161.0
        ),
        
        NAPFAAScores(age: 11,
            TwoPointFourKMRunUserSetScoreMale: 530.0,
            ShuttleRunUserSetScoreMale: 10.7,
            SitUpsUserSetScoreMale: 39.0,
            SitAndReachUserSetScoreMale: 37.0,
            InclinedPullupsUserSetScoreMale: 23.0,
            StandingBroadJumpUserSetScoreMale: 188.0,
                     
            TwoPointFourKMRunUserSetScoreFemale: 620.0,
            ShuttleRunUserSetScoreFemale: 11.6,
            SitUpsUserSetScoreFemale: 28.0,
            SitAndReachUserSetScoreFemale: 41.0,
            InclinedPullupsUserSetScoreFemale: 20.0,
            StandingBroadJumpUserSetScoreFemale: 164.0
        ),
        
        NAPFAAScores(age: 12,
            TwoPointFourKMRunUserSetScoreMale: 721,
            ShuttleRunUserSetScoreMale: 10.4,
            SitUpsUserSetScoreMale: 41.0,
            SitAndReachUserSetScoreMale: 39.0,
            InclinedPullupsUserSetScoreMale: 24.0,
            StandingBroadJumpUserSetScoreMale: 202.0,
                     
            TwoPointFourKMRunUserSetScoreFemale: 881.0,
            ShuttleRunUserSetScoreFemale: 11.5,
            SitUpsUserSetScoreFemale: 29.0,
            SitAndReachUserSetScoreFemale: 39.0,
            InclinedPullupsUserSetScoreFemale: 15.0,
            StandingBroadJumpUserSetScoreFemale: 167.0
        ),
        NAPFAAScores(age: 13,
            TwoPointFourKMRunUserSetScoreMale: 490.0,
            ShuttleRunUserSetScoreMale: 10.3,
            SitUpsUserSetScoreMale: 42.0,
            SitAndReachUserSetScoreMale: 41.0,
            InclinedPullupsUserSetScoreMale: 25.0,
            StandingBroadJumpUserSetScoreMale: 214.0,
                     
            TwoPointFourKMRunUserSetScoreFemale: 600.0,
            ShuttleRunUserSetScoreFemale: 11.3,
            SitUpsUserSetScoreFemale: 30.0,
            SitAndReachUserSetScoreFemale: 45.0,
            InclinedPullupsUserSetScoreFemale: 17.0,
            StandingBroadJumpUserSetScoreFemale: 170.0
        ),
        NAPFAAScores(age: 14,
            TwoPointFourKMRunUserSetScoreMale: 661.0,
            ShuttleRunUserSetScoreMale: 10.2,
            SitUpsUserSetScoreMale: 42.0,
            SitAndReachUserSetScoreMale: 43.0,
            InclinedPullupsUserSetScoreMale: 26.0,
            StandingBroadJumpUserSetScoreMale: 225.0,
                     
            TwoPointFourKMRunUserSetScoreFemale: 861.0,
            ShuttleRunUserSetScoreFemale: 11.5,
            SitUpsUserSetScoreFemale: 30.0,
            SitAndReachUserSetScoreFemale: 43.0,
            InclinedPullupsUserSetScoreFemale: 16.0,
            StandingBroadJumpUserSetScoreFemale: 177.0
        ),
        NAPFAAScores(age: 15,
            TwoPointFourKMRunUserSetScoreMale: 641.0,
            ShuttleRunUserSetScoreMale: 10.2,
            SitUpsUserSetScoreMale: 42.0,
            SitAndReachUserSetScoreMale: 45.0,
            InclinedPullupsUserSetScoreMale: 7.0,
            StandingBroadJumpUserSetScoreMale: 237.0,
            
            TwoPointFourKMRunUserSetScoreFemale: 851.0,
            ShuttleRunUserSetScoreFemale: 11.3,
            SitUpsUserSetScoreFemale: 30.0,
            SitAndReachUserSetScoreFemale: 45.0,
            InclinedPullupsUserSetScoreFemale: 16.0,
            StandingBroadJumpUserSetScoreFemale: 182.0
        ),
        NAPFAAScores(age: 16,
            TwoPointFourKMRunUserSetScoreMale: 631.0,
            ShuttleRunUserSetScoreMale: 10.2,
            SitUpsUserSetScoreMale: 42.0,
            SitAndReachUserSetScoreMale: 47.0,
            InclinedPullupsUserSetScoreMale: 8.0,
            StandingBroadJumpUserSetScoreMale: 245.0,
                    
            TwoPointFourKMRunUserSetScoreFemale: 851.0,
            ShuttleRunUserSetScoreFemale: 11.3,
            SitUpsUserSetScoreFemale: 30.0,
            SitAndReachUserSetScoreFemale: 46.0,
            InclinedPullupsUserSetScoreFemale: 17.0,
            StandingBroadJumpUserSetScoreFemale: 186.0
        ),
        NAPFAAScores(age: 17,
            TwoPointFourKMRunUserSetScoreMale: 621.0,
            ShuttleRunUserSetScoreMale: 10.2,
            SitUpsUserSetScoreMale: 42.0,
            SitAndReachUserSetScoreMale: 48.0,
            InclinedPullupsUserSetScoreMale: 9.0,
            StandingBroadJumpUserSetScoreMale: 249.0,
                     
            TwoPointFourKMRunUserSetScoreFemale: 841.0,
            ShuttleRunUserSetScoreFemale: 11.3,
            SitUpsUserSetScoreFemale: 30.0,
            SitAndReachUserSetScoreFemale: 46.0,
            InclinedPullupsUserSetScoreFemale: 17.0,
            StandingBroadJumpUserSetScoreFemale: 189.0
        ),
        NAPFAAScores(age: 18,
            TwoPointFourKMRunUserSetScoreMale: 621.0,
            ShuttleRunUserSetScoreMale: 10.2,
            SitUpsUserSetScoreMale: 42.0,
            SitAndReachUserSetScoreMale: 48.0,
            InclinedPullupsUserSetScoreMale: 10.0,
            StandingBroadJumpUserSetScoreMale: 251.0,
                    
            TwoPointFourKMRunUserSetScoreFemale: 841.0,
            ShuttleRunUserSetScoreFemale: 11.3,
            SitUpsUserSetScoreFemale: 30.0,
            SitAndReachUserSetScoreFemale: 46.0,
            InclinedPullupsUserSetScoreFemale: 17,
            StandingBroadJumpUserSetScoreFemale: 192.0
        ),
        NAPFAAScores(age: 19,
            TwoPointFourKMRunUserSetScoreMale: 621.0,
            ShuttleRunUserSetScoreMale: 10.2,
            SitUpsUserSetScoreMale: 42.0,
            SitAndReachUserSetScoreMale: 48.0,
            InclinedPullupsUserSetScoreMale: 10.0,
            StandingBroadJumpUserSetScoreMale: 251.0,
                    
            TwoPointFourKMRunUserSetScoreFemale: 861.0,
            ShuttleRunUserSetScoreFemale: 11.3,
            SitUpsUserSetScoreFemale: 30.0,
            SitAndReachUserSetScoreFemale: 45.0,
            InclinedPullupsUserSetScoreFemale: 17.0,
            StandingBroadJumpUserSetScoreFemale: 195.0
        ),
    ]
    
    
    // TODO: MAKE THIS TAKE FROM PERSISTENCE AND AUTOUPDATE BASED ON BDAY
    @State var age = 16
    @State var birthdayObj = Date()
    @State var TwoPointFourKMRunUserSetScore = 0.0
    @State var ShuttleRunUserSetScore = 0.0
    @State var SitUpsUserSetScore = 0.0
    @State var SitAndReachUserSetScore = 0.0
    @State var InclinedPullupsUserSetScore = 0.0
    @State var StandingBroadJumpUserSetScore = 0.0
    
    
    // TODO: MAKE THESE A(HIGHEST) SCORES ADAPT TO USER AGE
    @State var TwoPointFourKMRunHighestScore = 641.0
    @State var ShuttleRunHighestScore = 10.2
    @State var SitUpsHighestScore = 42.0
    @State var SitAndReachHighestScore = 45.0
    @State var InclinedPullupsHighestScore = 7.0
    @State var StandingBroadJumpHighestScore = 237.0
    
    
    // This is to get user's goals, etc
    @State var showModal = false
    
    
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
    @State var sizeOfBigProgress = CGSize(width: 300, height: 300)
    
    @ViewBuilder
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        ScrollViewReader { proxy in
                            SnappingScrollView(.horizontal, decelerationRate: .normal, showsIndicators: true) {
                                ForEach(data) { datum in
                                    if (datum.fractionWorkoutForUserGoal != 0 && datum.fractionWorkoutForUserGoal.isFinite) {
                                        Spacer()
                                        
                                        HStack(alignment: .center) {
                                            VStack(alignment: .center) {
                                                CircularProgressViewLargeIcon(progress: datum.fractionWorkoutForUserGoal.isInfinite ? 0 : datum.fractionWorkoutForUserGoal, screenGeo: geometry.size, sfSymbolNameTop: "target", sfSymbolNameBottom: "", content: {
                                                    CircularProgressViewLargeIcon(progress: datum.fractionWorkoutForA.isInfinite ? 0 : datum.fractionWorkoutForA, screenGeo: geometry.size, sfSymbolNameTop: "a.circle", sfSymbolNameBottom: "", content: {
                                                            Text(datum.text)
                                                            .font(.title3)
                                                            .multilineTextAlignment(.center)
                                                            .padding(geometry.size.width / 9)
                                                    })
                                                    .padding(geometry.size.width / 10)
                                                })
                                                .frame(width:UIScreen.main.bounds.width-90, height: UIScreen.main.bounds.width-90, alignment: .center)
                                            }
                                        }
                                        .padding(.top, 10)
                                        .padding()
                                        .padding()
                                        .background(
                                            GeometryReader { geometryProxy in
                                                Color.clear
                                                    .onAppear {
                                                        sizeOfBigProgress = geometryProxy.size
                                                    }
                                            }
                                        )
                                        
                                        Spacer()
                                            .scrollSnappingAnchor(.bounds)
                                            .id(idGen(text: datum.text))
                                        
                                    } else {
                                        Spacer()
                                        
                                        HStack(alignment: .center) {
                                            VStack(alignment: .center) {
                                                CircularProgressViewLargeIcon(progress: datum.fractionWorkoutForA.isInfinite ? 0 : datum.fractionWorkoutForA, screenGeo: geometry.size, sfSymbolNameTop: "figure.walk", sfSymbolNameBottom: "questionmark.circle", content: {
                                                    CircularProgressViewLargeIcon(progress: datum.fractionNAPFA.isInfinite ? 0 : datum.fractionNAPFA, screenGeo: geometry.size, sfSymbolNameTop: "figure.run", sfSymbolNameBottom: "", content: {
                                                            Text(datum.text).font(.title3)
                                                                .multilineTextAlignment(.center)
                                                                .padding(geometry.size.width / 9)
                                                    })
                                                    .padding(geometry.size.width / 10)
                                                })
                                                .frame(width:UIScreen.main.bounds.width-90, height: UIScreen.main.bounds.width-90, alignment: .center)
                                            }
                                        }
                                        .padding(.top, 10)
                                        .padding()
                                        .padding()
                                        .background(
                                            GeometryReader { geometryProxy in
                                                Color.clear
                                                    .onAppear {
                                                        sizeOfBigProgress = geometryProxy.size
                                                    }
                                            }
                                        )
                                        
                                        Spacer()
                                            .scrollSnappingAnchor(.bounds)
                                            .id(idGen(text: datum.text))
                                    }
                                }
                                
                                
                                ZStack {
                                    
                                }
                                .frame(width: sizeOfBigProgress.width * 0.01, height: sizeOfBigProgress.height * 0.01)
                                
                            }
                        }
                        
                        
                        Form {
                            Section {
                                
                                HStack {
                                    Image(systemName: "arrowshape.left.fill")
                                    Spacer()
                                    Text("Swipe left or right on the rings to view more stations")
                                        .multilineTextAlignment(.center)
                                        .font(.footnote)
                                    Spacer()
                                    Image(systemName: "arrowshape.right.fill")
                                }
                                if stillHaveUnsetGoals {
                                    Button {
                                        showModal = true
                                    } label: {
                                        HStack {
                                            Image(systemName: "info.circle")
                                                .font(.title3)
                                            Text("You seem to have some unset goals. You can set some now.")
                                                .multilineTextAlignment(.leading)
                                        }
                                    }
                                }
                                
                                if stillNeedFillNAPFAEntry {
                                    Button {
                                        self.tabSelection = 2
                                    } label: {
                                        HStack {
                                            Image(systemName: "info.circle")
                                                .font(.title3)
                                            Text("You do not seem to have a log of your offical NAPFA score. You can set this in the logger.")
                                        }
                                    }
                                }
                                
                                if stillNeedFillWorkoutEntry {
                                    Button {
                                        self.tabSelection = 2
                                    } label: {
                                        HStack {
                                            Image(systemName: "info.circle")
                                                .font(.title3)
                                            Text("You do not seem to have a log of your mock (Practise) NAPFA score. You can set this in the logger.")
                                        }
                                    }
                                }
                                
                            }
                            Section {
                                Button("Go to Workouts") {
                                    withAnimation {
                                        self.tabSelection = 1
                                    }
                                }
                                Button("Go to Logger") {
                                    withAnimation {
                                        self.tabSelection = 2
                                    }
                                }
                                Button("Go to Calculator") {
                                    withAnimation {
                                        self.tabSelection = 3
                                    }
                                }
                            }
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    if (TwoPointFourKMRunUserSetScore == 0.0 || SitUpsUserSetScore == 0.0 || SitAndReachUserSetScore == 0.0 || InclinedPullupsUserSetScore == 0.0 || ShuttleRunUserSetScore == 0.0 || StandingBroadJumpUserSetScore == 0.0) {
                                        withAnimation {
                                            stillHaveUnsetGoals = true
                                        }
                                        print("still unset goals")
                                    } else {
                                        withAnimation {
                                            stillHaveUnsetGoals = false
                                        }
                                    }
                                    
                                    if (lastNAPFAElement.twoPointFourKMRun == "0" && lastNAPFAElement.shuttleRun == "0" && lastNAPFAElement.sitUps == "0" && lastNAPFAElement.sitAndReach == "0" && lastNAPFAElement.inclinedPullups == "0" && lastNAPFAElement.standingBroadJump == "0")
//                                     LogRecord(
//                                        NapfaOrWorkouts: .napfa,
//                                        description: "This is my description",
//                                        date: Date(timeInterval: .zero, since: .now),
//                                        twoPointFourKMRun: "0",
//                                        shuttleRun: "0",
//                                        sitUps: "0",
//                                        sitAndReach: "0",
//                                        inclinedPullups: "0",
//                                        standingBroadJump: "0"
//                                    )
                                    {
                                        withAnimation {
                                            stillNeedFillNAPFAEntry = true
                                        }
                                    } else {
                                        withAnimation {
                                            stillNeedFillNAPFAEntry = false
                                        }
                                    }
                                    
                                    if (lastWorkoutElement.twoPointFourKMRun == "0" && lastWorkoutElement.shuttleRun == "0" && lastWorkoutElement.sitUps == "0" && lastWorkoutElement.sitAndReach == "0" && lastWorkoutElement.inclinedPullups == "0" && lastWorkoutElement.standingBroadJump == "0")
//                                        LogRecord(
//                                        NapfaOrWorkouts: .workout,
//                                        description: "This is my description",
//                                        date: Date(timeInterval: .zero, since: .now),
//                                        twoPointFourKMRun: "0",
//                                        shuttleRun: "0",
//                                        sitUps: "0",
//                                        sitAndReach: "0",
//                                        inclinedPullups: "0",
//                                        standingBroadJump: "0"
//                                    )
                                    {
                                        withAnimation {
                                            stillNeedFillWorkoutEntry = true
                                        }
                                    } else {
                                        withAnimation {
                                            stillNeedFillWorkoutEntry = false
                                        }
                                    }
                                }
                            }
                        }
                        .sheet(isPresented: $showModal) {
                            showModal = false
                        } content: {
                            getGoalData(age: $age, birthDate: $birthdayObj, twoPointFourKMRunScore: $TwoPointFourKMRunUserSetScore, standingBroadJumpScore: $StandingBroadJumpUserSetScore, inclinedPullupsScore: $InclinedPullupsUserSetScore, shuttleRunScore: $ShuttleRunUserSetScore, sitUpsScore: $SitUpsUserSetScore, sitAndReachScore: $SitAndReachUserSetScore)
                        }
                        
                    }.navigationTitle("Overview")
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarItems(trailing:
                                            Button {
                            showModal = true
                        } label: {
                            Image(systemName: "target")
                        }
                        )
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
                                     fractionWorkoutForA: TwoPointFourKMRunHighestScore / Double(lastWorkoutElement.twoPointFourKMRun)!,
                                     fractionWorkoutForUserGoal: TwoPointFourKMRunUserSetScore == 0.0 ? 0.0 :
                                        TwoPointFourKMRunUserSetScore / Double(lastWorkoutElement.twoPointFourKMRun)!),
                        ProgressData(text: "Situps",
                                     fractionNAPFA: Double(lastNAPFAElement.sitUps)! / SitUpsHighestScore,
                                     fractionWorkoutForA: Double(lastWorkoutElement.sitUps)! / SitUpsHighestScore,
                                     fractionWorkoutForUserGoal: SitUpsUserSetScore == 0.0 ? 0.0 : Double(lastWorkoutElement.sitUps)! / SitUpsUserSetScore),
                        ProgressData(text: "Inclined Pullups",
                                     fractionNAPFA: Double(lastNAPFAElement.inclinedPullups)! / InclinedPullupsHighestScore,
                                     fractionWorkoutForA: Double(lastWorkoutElement.inclinedPullups)! / InclinedPullupsHighestScore,
                                     fractionWorkoutForUserGoal: InclinedPullupsUserSetScore == 0.0 ? 0.0 : Double(lastWorkoutElement.inclinedPullups)! / InclinedPullupsUserSetScore),
                        ProgressData(text: "Sit & Reach",
                                     fractionNAPFA: Double(lastNAPFAElement.sitAndReach)! / SitAndReachHighestScore,
                                     fractionWorkoutForA: Double(lastWorkoutElement.sitAndReach)! / SitAndReachHighestScore,
                                     fractionWorkoutForUserGoal: SitAndReachUserSetScore == 0.0 ? 0.0 : Double(lastWorkoutElement.sitAndReach)! / SitAndReachUserSetScore),
                        ProgressData(text: "Shuttle Run",
                                     fractionNAPFA: ShuttleRunHighestScore / Double(lastNAPFAElement.shuttleRun)!,
                                     fractionWorkoutForA: ShuttleRunHighestScore / Double(lastWorkoutElement.shuttleRun)!,
                                     fractionWorkoutForUserGoal: ShuttleRunUserSetScore == 0.0 ? 0.0 : ShuttleRunUserSetScore / Double(lastWorkoutElement.shuttleRun)!),
                        ProgressData(text: "Standing Broad Jump",
                                     fractionNAPFA: Double(lastNAPFAElement.standingBroadJump)! / StandingBroadJumpHighestScore,
                                     fractionWorkoutForA: Double(lastWorkoutElement.standingBroadJump)! / StandingBroadJumpHighestScore,
                                     fractionWorkoutForUserGoal: StandingBroadJumpUserSetScore == 0.0 ? 0.0 : Double(lastWorkoutElement.standingBroadJump)! / StandingBroadJumpUserSetScore)
                    ]
                    
                    print(data[0].text + " " + String(data[0].fractionWorkoutForUserGoal))
                    print(data[1].text + " " + String(data[1].fractionWorkoutForUserGoal))
                    print(data[2].text + " " + String(data[2].fractionWorkoutForUserGoal))
                    print(data[3].text + " " + String(data[3].fractionWorkoutForUserGoal))
                    print(data[4].text + " " + String(data[4].fractionWorkoutForUserGoal))
                    print(data[5].text + " " + String(data[5].fractionWorkoutForUserGoal))
                }
            }
        }
    }
}


struct getGoalData: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var age: Int
    @Binding var birthDate: Date
    @Binding var twoPointFourKMRunScore: Double
    @Binding var standingBroadJumpScore: Double
    @Binding var inclinedPullupsScore: Double
    @Binding var shuttleRunScore: Double
    @Binding var sitUpsScore: Double
    @Binding var sitAndReachScore: Double
    
    @State var showAlert = false
    
    @State var twoPointFourKMRun = ""
    @State var standingBroadJump = ""
    @State var inclinedPullups = ""
    @State var shuttleRun = ""
    @State var sitUps = ""
    @State var sitAndReach = ""
    
    var dateClosedRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -17, to: Date())!
        let max = Calendar.current.date(byAdding: .year, value: -8, to: Date())!
        return min...max
    }
    
    
    var body: some View {
        NavigationView {
            HStack {
                Form {
                    Section {
                        DatePicker(selection: $birthDate, in: dateClosedRange, displayedComponents: [.date], label: { Text("Your Birthday") })
                    } footer: {
                        Text("We need your birthday to allow us to calculate your NAPFA Scores. This data will be kept confidential and will not be uploaded to any cloud server.")
                    }

                    
                    Section {
                        Text("2.4KM Run")
                        TextField(String(
                            Int(twoPointFourKMRunScore)), text: $twoPointFourKMRun)
                            .keyboardType(.numberPad)
                    } footer: {
                        Text("Seconds")
                    }
                    
                    Section {
                        Text("Sit And Reach")
                        TextField(String(sitAndReachScore), text: $sitAndReach)
                            .keyboardType(.numberPad)
                    } footer: {
                        Text("CM")
                    }
                    
                    Section {
                        Text("Standing Broad Jump")
                        TextField(String(standingBroadJumpScore), text: $standingBroadJump)
                            .keyboardType(.numberPad)
                    } footer: {
                        Text("CM")
                    }
                    
                    Section {
                        Text("Inclined Pullups (In 30 seconds)")
                        TextField(String(Int(inclinedPullupsScore)), text: $inclinedPullups)
                            .keyboardType(.numberPad)
                    } footer: {
                        Text("Reps")
                    }
                    
                    Section {
                        Text("Shuttle Run")
                        TextField(String(shuttleRunScore), text: $shuttleRun)
                            .keyboardType(.numberPad)
                    } footer: {
                        Text("Seconds")
                    }
                    
                    Section {
                        Text("Situps (In 1 min)")
                        TextField(String(Int(sitUpsScore)), text: $sitUps)
                            .keyboardType(.numberPad)
                    } footer: {
                        Text("Reps")
                    }
                }
            }
            .navigationTitle("Set Your Goals")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button {
                dismiss()
            } label: {Text("Cancel").foregroundColor(.red)})
            
            .navigationBarItems(trailing: Button {
                if (Float(twoPointFourKMRun) != nil && Float(sitAndReach) != nil && Float(standingBroadJump) != nil && Float(inclinedPullups) != nil && Float(shuttleRun) != nil && Float(sitUps) != nil || twoPointFourKMRun == "" || sitAndReach == "" || standingBroadJump == "" || inclinedPullups == "" || shuttleRun == "" || sitUps == "") {
                    twoPointFourKMRunScore = Double(twoPointFourKMRun) ?? twoPointFourKMRunScore
                    standingBroadJumpScore = Double(standingBroadJump) ?? standingBroadJumpScore
                    inclinedPullupsScore = Double(inclinedPullups) ?? inclinedPullupsScore
                    shuttleRunScore = Double(shuttleRun) ?? shuttleRunScore
                    sitUpsScore = Double(sitUps) ?? sitUpsScore
                    sitAndReachScore = Double(sitAndReach) ?? sitAndReachScore
                    
                    let calendar = Calendar.current
                    let ageComponents = calendar.dateComponents([.year], from: birthDate, to: Date())
                    age = ageComponents.year!
                    
                    dismiss()
                    
                } else {
                    showAlert = true
                }
            } label: {Text("Set").foregroundColor(.blue)})
        }
        .alert("Error!", isPresented: $showAlert) {
            Button("Ok") {}
        } message: {
            Text("Please ensure that the values entered are numbers and are not left blank.")
        }
    }
}


struct InternalButtonIconView: View {
    var body: some View {
        Image(systemName: "Arrow.right")
    }
}


struct HomeView_Previews: PreviewProvider {
    @State static var a = 1
    static var previews: some View {
        HomeView(tabSelection: $a)
    }
}

//struct HomeViewModal_Previews: PreviewProvider {
//    @State static var a = 1.0
//    @State static var b = 1
//    @State static var c = Date()
//    static var previews: some View {
//        getGoalData(age: $b, birthDate: $c, twoPointFourKMRunScore: $a, standingBroadJumpScore: $a, inclinedPullupsScore: $a, shuttleRunScore: $a, sitUpsScore: $a, sitAndReachScore: $a)
//    }
//}
