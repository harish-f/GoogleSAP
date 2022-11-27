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

enum Gender {
    case male
    case female
    case none
}

//  - Replace Text with symbols
//  - Switch the weird picker thing for a textfield
//  - Colour Scheme

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
    @ObservedObject var HomeManager = HomeDataManager()
    @Environment(\.colorScheme) var colorScheme
    
    
    @State var refresher = 0
    @State var hasUserNotViewedInstructionsOnce = false
    
    @State var stillHaveUnsetGoals = false
    @State var stillNeedFillNAPFAEntry = false
    @State var stillNeedFillWorkoutEntry = false
    
    @State var isAgeLegal = true
    @State var firstTimeEnteringAge = true
    
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
    
    @State var userAgeBasedBestScore = NAPFAAScores(age: 0, TwoPointFourKMRunUserSetScoreMale: 0.0, ShuttleRunUserSetScoreMale: 0.0, SitUpsUserSetScoreMale: 0.0, SitAndReachUserSetScoreMale: 0.0, InclinedPullupsUserSetScoreMale: 0.0, StandingBroadJumpUserSetScoreMale: 0.0, TwoPointFourKMRunUserSetScoreFemale: 0.0, ShuttleRunUserSetScoreFemale: 0.0, SitUpsUserSetScoreFemale: 0.0, SitAndReachUserSetScoreFemale: 0.0, InclinedPullupsUserSetScoreFemale: 0.0, StandingBroadJumpUserSetScoreFemale: 0.0)
    
    
    // TODO: MAKE THIS TAKE FROM PERSISTENCE AND AUTOUPDATE BASED ON BDAY
    @State var gender: Gender = .male
    @State var age = 0
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
                        if (refresher != 0) {
                            SnappingScrollView(.horizontal, decelerationRate: .normal, showsIndicators: false) {
                                ForEach(data) { datum in
                                    if (datum.fractionWorkoutForUserGoal != 0 && datum.fractionWorkoutForUserGoal.isFinite) {
                                        Spacer()
                                        CircularProgView(datum: datum, outerRingFraction: datum.fractionWorkoutForUserGoal, innerRingFraction: datum.fractionWorkoutForA, age: age, geometry: geometry, refresher: $refresher, updateProgressSize: $sizeOfBigProgress, outerRingTopSymbol: "target", outerRingBottomSymbol: "", innerRingTopSymbol: "a.circle", innerRingBottomSymbol: "")
                                            .frame(width:UIScreen.main.bounds.width-90, height: UIScreen.main.bounds.width-90, alignment: .center)
                                            .padding(.top, 10)
                                            .padding()
                                            .padding()
                                        
                                        Spacer()
                                            .scrollSnappingAnchor(.bounds)
                                            .id(idGen(text: datum.text))
                                        
                                    } else {
                                        Spacer()
                                        CircularProgView(datum: datum, outerRingFraction: datum.fractionWorkoutForA, innerRingFraction: datum.fractionNAPFA, age: age, geometry: geometry, refresher: $refresher, updateProgressSize: $sizeOfBigProgress, outerRingTopSymbol: "figure.walk", outerRingBottomSymbol: "", innerRingTopSymbol: "figure.run", innerRingBottomSymbol: "")
                                            .frame(width:UIScreen.main.bounds.width-90, height: UIScreen.main.bounds.width-90, alignment: .center)
                                            .padding(.top, 10)
                                            .padding()
                                            .padding()
                                        
                                        Spacer()
                                            .scrollSnappingAnchor(.bounds)
                                            .id(idGen(text: datum.text))
                                    }
                                }
                                
                                
                                ZStack {
                                    
                                }
                                .frame(width: sizeOfBigProgress.width * 0.01, height: sizeOfBigProgress.height * 0.01)
                                
                            }
                        } else {
                            ProgressView()
                                .frame(width: geometry.size.width, height: geometry.size.width)
                        }
                        
                        
                        //                            ZStack {
                        //
                        //                            }
                        //                            .frame(width: sizeOfBigProgress.width * 0.01, height: sizeOfBigProgress.height * 0.01)
                        
                        //                            }
                        //                        }
                        
                        
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
                                
                                if !isAgeLegal && !firstTimeEnteringAge {
                                    Button {
                                        showModal = true
                                    } label: {
                                        HStack {
                                            Image(systemName: "info.circle")
                                                .font(.title3)
                                            Text("It seems like your age does not fall into any napfa scoring standards that we can use. Please update your age to be within the range of 9-19 inclusive.")
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
                                HomeManager.loadData()
                                
                                age = HomeManager.stationData[0].age
                                birthdayObj = HomeManager.stationData[0].ageDate
                                TwoPointFourKMRunUserSetScore = HomeManager.stationData[0].TwoPointFourKMRun
                                SitUpsUserSetScore = HomeManager.stationData[0].SitUps
                                SitAndReachUserSetScore = HomeManager.stationData[0].StandingBroadJump
                                InclinedPullupsUserSetScore = HomeManager.stationData[0].InclinedPullups
                                ShuttleRunUserSetScore = HomeManager.stationData[0].ShuttleRun
                                StandingBroadJumpUserSetScore = HomeManager.stationData[0].StandingBroadJump
                                hasUserNotViewedInstructionsOnce = HomeManager.stationData[0].hasUserNotSawInstructions
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    userAgeBasedBestScore = listOfNapfaScores.last { score in
                                        score.age == age
                                    } ?? NAPFAAScores(age: 0, TwoPointFourKMRunUserSetScoreMale: 0.0, ShuttleRunUserSetScoreMale: 0.0, SitUpsUserSetScoreMale: 0.0, SitAndReachUserSetScoreMale: 0.0, InclinedPullupsUserSetScoreMale: 0.0, StandingBroadJumpUserSetScoreMale: 0.0, TwoPointFourKMRunUserSetScoreFemale: 0.0, ShuttleRunUserSetScoreFemale: 0.0, SitUpsUserSetScoreFemale: 0.0, SitAndReachUserSetScoreFemale: 0.0, InclinedPullupsUserSetScoreFemale: 0.0, StandingBroadJumpUserSetScoreFemale: 0.0)
                                    
                                    if listOfNapfaScores.last(where: { score in score.age == age }) ?? nil == nil {
                                        withAnimation {
                                            isAgeLegal = false
                                        }
                                    } else {
                                        if (gender == .male) {
                                            StandingBroadJumpHighestScore = userAgeBasedBestScore.StandingBroadJumpUserSetScoreMale
                                            
                                            TwoPointFourKMRunHighestScore = userAgeBasedBestScore.TwoPointFourKMRunUserSetScoreMale
                                            
                                            InclinedPullupsHighestScore = userAgeBasedBestScore.InclinedPullupsUserSetScoreMale
                                            
                                            SitUpsHighestScore = userAgeBasedBestScore.SitUpsUserSetScoreMale
                                            
                                            SitAndReachHighestScore = userAgeBasedBestScore.SitAndReachUserSetScoreMale
                                            
                                            TwoPointFourKMRunHighestScore = userAgeBasedBestScore.TwoPointFourKMRunUserSetScoreMale
                                        } else if (gender == .female) {
                                            StandingBroadJumpHighestScore = userAgeBasedBestScore.StandingBroadJumpUserSetScoreFemale
                                            
                                            TwoPointFourKMRunHighestScore = userAgeBasedBestScore.TwoPointFourKMRunUserSetScoreFemale
                                            
                                            InclinedPullupsHighestScore = userAgeBasedBestScore.InclinedPullupsUserSetScoreFemale
                                            
                                            SitUpsHighestScore = userAgeBasedBestScore.SitUpsUserSetScoreFemale
                                            
                                            SitAndReachHighestScore = userAgeBasedBestScore.SitAndReachUserSetScoreFemale
                                            
                                            TwoPointFourKMRunHighestScore = userAgeBasedBestScore.TwoPointFourKMRunUserSetScoreFemale
                                        }
                                        withAnimation {
                                            isAgeLegal = true
                                        }
                                    }
                                    
                                    if (TwoPointFourKMRunUserSetScore == 0.0 || SitUpsUserSetScore == 0.0 || SitAndReachUserSetScore == 0.0 || InclinedPullupsUserSetScore == 0.0 || ShuttleRunUserSetScore == 0.0 || StandingBroadJumpUserSetScore == 0.0) {
                                        withAnimation {
                                            stillHaveUnsetGoals = true
                                        }
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
                                    if refresher == 0 {
                                        withAnimation {
                                            refresher = refresher + 1
                                        }
                                    }
                                }
                                
                            }
                        }
                        .sheet(isPresented: $showModal) {
                            showModal = false
                            tabSelection = 0
                            HomeManager.stationData = [
                                UserSetScore(hasUserNotSawInstructions: hasUserNotViewedInstructionsOnce, age: age, ageDate: birthdayObj, TwoPointFourKMRun: TwoPointFourKMRunUserSetScore, ShuttleRun: ShuttleRunUserSetScore, SitUps: SitUpsUserSetScore, SitAndReach: SitAndReachUserSetScore, InclinedPullups: InclinedPullupsUserSetScore, StandingBroadJump: StandingBroadJumpUserSetScore)
                            ]
                            HomeManager.saveData()
                            refresher = refresher + 1
                            
                        } content: {
                            getGoalData(refresher: $refresher, tabSelection: $tabSelection, age: $age, firstTimeEnterAge: $firstTimeEnteringAge, gender: $gender, birthDate: $birthdayObj, twoPointFourKMRunScore: $TwoPointFourKMRunUserSetScore, standingBroadJumpScore: $StandingBroadJumpUserSetScore, inclinedPullupsScore: $InclinedPullupsUserSetScore, shuttleRunScore: $ShuttleRunUserSetScore, sitUpsScore: $SitUpsUserSetScore, sitAndReachScore: $SitAndReachUserSetScore)
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
                        .navigationBarItems(leading:
                                                Button("Tutorial") {
                            hasUserNotViewedInstructionsOnce = true
                        }
                                            )
//                                                ZStack {
//                            if (refresher == 0) {
//                                ProgressView()
//                            } else {
//                                EmptyView()
//                            }
                        .sheet(isPresented: $hasUserNotViewedInstructionsOnce) {
                            hasUserNotViewedInstructionsOnce = false
                            HomeManager.stationData = [
                                UserSetScore(hasUserNotSawInstructions: hasUserNotViewedInstructionsOnce, age: age, ageDate: birthdayObj, TwoPointFourKMRun: TwoPointFourKMRunUserSetScore, ShuttleRun: ShuttleRunUserSetScore, SitUps: SitUpsUserSetScore, SitAndReach: SitAndReachUserSetScore, InclinedPullups: InclinedPullupsUserSetScore, StandingBroadJump: StandingBroadJumpUserSetScore)
                            ]
                            HomeManager.saveData()
                        } content: {
                            InstructionsView()
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
                }
            }
        }.id(refresher)
    }
}

struct InstructionsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                // HI RACHEL PUT STUFF HERE THANKS
            }
        }
    }
}

struct InstructionView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsView()
    }
}


struct getGoalData: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var refresher: Int
    @Binding var tabSelection: Int
    @Binding var age: Int
    @Binding var firstTimeEnterAge: Bool
    @Binding var gender: Gender
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
        let min = Calendar.current.date(byAdding: .year, value: -19, to: Date())!
        let max = Calendar.current.date(byAdding: .year, value: -8, to: Date())!
        return min...max
    }
    
    
    var body: some View {
        NavigationView {
            HStack {
                Form {
                    Section {
                        DatePicker(selection: $birthDate, in: dateClosedRange, displayedComponents: [.date], label: { Text("Your Birthday") })
                        Picker(selection: $gender, label: Text("Gender")) {
                            Text("Male").tag(Gender.male)
                            Text("Female").tag(Gender.female)
                        }
                    } footer: {
                        Text("We need your birthday and gender to allow us to calculate your NAPFA Scores. This data will be kept confidential and will not be uploaded to any cloud server.")
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
            .onAppear {
                withAnimation {
                    firstTimeEnterAge = false
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
                    
                    tabSelection = 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        tabSelection = 0
                        refresher = 0
                    }
                    
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

struct CircularProgView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var datum: ProgressData
    var outerRingFraction: Double
    var innerRingFraction: Double
    var age: Int
    var geometry: GeometryProxy
    
    @Binding var refresher: Int
    @Binding var updateProgressSize: CGSize
    
    var outerRingTopSymbol: String
    var outerRingBottomSymbol: String
    var innerRingTopSymbol: String
    var innerRingBottomSymbol: String
    //     datum.fractionWorkoutForA
    //     datum.fractionNAPFA
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .center) {
                CircularProgressViewLargeIcon(progress: outerRingFraction.isInfinite ? 0 : outerRingFraction, refresh: $refresher, screenGeo: geometry.size, sfSymbolNameTop: outerRingTopSymbol, sfSymbolNameBottom: outerRingBottomSymbol, content: {
                    CircularProgressViewLargeIcon(progress: innerRingFraction.isInfinite ? 0 : innerRingFraction, refresh: $refresher, screenGeo: geometry.size, sfSymbolNameTop: innerRingTopSymbol, sfSymbolNameBottom: innerRingBottomSymbol, content: {
                        if (datum.text == "Inclined Pullups" && age <= 14) {
                            VStack {
                                Spacer()
                                Spacer()
                                if colorScheme == .dark {
                                    Image("PullupsDark")
                                        .resizable()
                                        .frame(width: geometry.size.width / 5, height: geometry.size.width / 5)
                                    
                                } else {
                                    Image("PullupsLight")
                                        .resizable()
                                        .frame(width: geometry.size.width / 5, height: geometry.size.width / 5)
                                }
                                Text(datum.text)
                                    .font(.title3)
                                    .multilineTextAlignment(.center)
                                    .padding(geometry.size.width / 9)
                                    .padding(.top, -(geometry.size.width / 10))
                                Spacer()
                            }
                        } else if (datum.text == "Inclined Pullups" && age >= 15) {
                            VStack {
                                Spacer()
                                Spacer()
                                if colorScheme == .dark {
                                    Image("PullupsDark")
                                        .resizable()
                                        .frame(width: geometry.size.width / 5, height: geometry.size.width / 5)
                                    
                                } else {
                                    Image("PullupsLight")
                                        .resizable()
                                        .frame(width: geometry.size.width / 5, height: geometry.size.width / 5)
                                }
                                Text("Pullups")
                                    .font(.title3)
                                    .multilineTextAlignment(.center)
                                    .padding(geometry.size.width / 9)
                                    .padding(.top, -(geometry.size.width / 10))
                                Spacer()
                            }
                        } else if (datum.text == "2.4 Run") {
                            VStack {
                                Spacer()
                                Spacer()
                                if colorScheme == .dark {
                                    Image("RunningDark")
                                        .resizable()
                                        .frame(width: geometry.size.width / 5, height: geometry.size.width / 5)
                                    
                                } else {
                                    Image("RunningLight")
                                        .resizable()
                                        .frame(width: geometry.size.width / 5, height: geometry.size.width / 5)
                                }
                                Text(datum.text)
                                    .font(.title3)
                                    .multilineTextAlignment(.center)
                                    .padding(geometry.size.width / 9)
                                    .padding(.top, -(geometry.size.width / 10))
                                Spacer()
                            }
                        } else if (datum.text == "Situps") {
                            VStack {
                                Spacer()
                                Spacer()
                                if colorScheme == .dark {
                                    Image("SitupsDark")
                                        .resizable()
                                        .frame(width: geometry.size.width / 5, height: geometry.size.width / 5)
                                    
                                } else {
                                    Image("SitupsLight")
                                        .resizable()
                                        .frame(width: geometry.size.width / 5, height: geometry.size.width / 5)
                                }
                                Text(datum.text)
                                    .font(.title3)
                                    .multilineTextAlignment(.center)
                                    .padding(geometry.size.width / 9)
                                    .padding(.top, -(geometry.size.width / 10))
                                Spacer()
                            }
                        } else if (datum.text == "Sit & Reach") {
                            VStack {
                                Spacer()
                                Spacer()
                                if colorScheme == .dark {
                                    Image("SitAndReachDark")
                                        .resizable()
                                        .frame(width: geometry.size.width / 5, height: geometry.size.width / 5)
                                    
                                } else {
                                    Image("SitAndReachLight")
                                        .resizable()
                                        .frame(width: geometry.size.width / 5, height: geometry.size.width / 5)
                                }
                                Text(datum.text)
                                    .font(.title3)
                                    .multilineTextAlignment(.center)
                                    .padding(geometry.size.width / 9)
                                    .padding(.top, -(geometry.size.width / 10))
                                Spacer()
                            }
                        } else if (datum.text == "Shuttle Run") {
                            VStack {
                                Spacer()
                                Spacer()
                                if colorScheme == .dark {
                                    Image("ShuttleRunDark")
                                        .resizable()
                                        .frame(width: geometry.size.width / 5, height: geometry.size.width / 5)
                                    
                                } else {
                                    Image("ShuttleRunLight")
                                        .resizable()
                                        .frame(width: geometry.size.width / 5, height: geometry.size.width / 5)
                                }
                                Text(datum.text)
                                    .font(.title3)
                                    .multilineTextAlignment(.center)
                                    .padding(geometry.size.width / 9)
                                    .padding(.top, -(geometry.size.width / 10))
                                Spacer()
                            }
                        } else if (datum.text == "Standing Broad Jump") {
                            VStack {
                                Spacer()
                                Spacer()
                                if colorScheme == .dark {
                                    Image("SBJDark")
                                        .resizable()
                                        .frame(width: geometry.size.width / 5, height: geometry.size.width / 5)
                                    
                                } else {
                                    Image("SBJLight")
                                        .resizable()
                                        .frame(width: geometry.size.width / 5, height: geometry.size.width / 5)
                                }
                                Text(datum.text)
                                    .font(.title3)
                                    .multilineTextAlignment(.center)
                                    .padding(geometry.size.width / 9)
                                    .padding(.top, -(geometry.size.width / 10))
                                Spacer()
                            }
                        }
                    })
                    //                                                    .id(Date())
                    .id(refresher)
                    .padding(geometry.size.width / 10)
                })
                //                                                .id(Date())
                .id(refresher)
            }
        }
        .background(
            GeometryReader { geometryProxy in
                Color.clear
                    .onAppear {
                        updateProgressSize = geometryProxy.size
                    }
            }
        )
    }
}
