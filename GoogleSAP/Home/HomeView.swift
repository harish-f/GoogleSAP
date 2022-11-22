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
    @Binding var tabSelection: Int
    
    @ObservedObject var loggerHistoryManager = LoggerDataManager()
    
    @State var autoScroll = true
    
    // TODO: MAKE THIS TAKE FROM PERSISTENCE AND AUTOUPDATE BASED ON BDAY
    @State var age = 16
    @State var TwoPointFourKMRunUserSetScore = 641.0
    @State var ShuttleRunUserSetScore = 10.2
    @State var SitUpsUserSetScore = 42.0
    @State var SitAndReachUserSetScore = 45.0
    @State var InclinedPullupsUserSetScore = 7.0
    @State var StandingBroadJumpUserSetScore = 237.0
    
    
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
    @State var sizeOfBigProgress = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        ScrollViewReader { proxy in
                            SnappingScrollView(.horizontal, decelerationRate: .fast, showsIndicators: true) {
                                ForEach(data) { datum in
                                    Spacer()
                                    HStack(alignment: .center) {
                                        VStack(alignment: .center) {
                                            CircularProgressViewLargeIcon(progress: datum.fractionWorkout, sfSymbolName: "a.circle", content: {
                                                CircularProgressViewLargeIcon(progress: datum.fractionNAPFA, sfSymbolName: "target", content: {
                                                    Button {
                                                        proxy.scrollTo(idGen(text: datum.text))
                                                    } label: {
                                                        Text(datum.text).font(.title3)
                                                    }
                                                })
                                                .padding(45)
                                            })
                                            .frame(width:UIScreen.main.bounds.width-50, height: UIScreen.main.bounds.width-50, alignment: .center)
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
                        }
                        .sheet(isPresented: $showModal) {
                            showModal = false
                        } content: {
                            getGoalData(twoPointFourKMRunScore: $TwoPointFourKMRunUserSetScore, standingBroadJumpScore: $StandingBroadJumpUserSetScore, inclinedPullupsScore: $InclinedPullupsUserSetScore, shuttleRunScore: $ShuttleRunUserSetScore, sitUpsScore: $SitUpsUserSetScore, sitAndReachScore: $SitAndReachUserSetScore)
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


struct getGoalData: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var twoPointFourKMRunScore: Double
    @Binding var standingBroadJumpScore: Double
    @Binding var inclinedPullupsScore: Double
    @Binding var shuttleRunScore: Double
    @Binding var sitUpsScore: Double
    @Binding var sitAndReachScore: Double
    
    @State var showAlert = false
    @State var birthdate = Date()
    
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
                        DatePicker(selection: $birthdate, in: dateClosedRange, displayedComponents: [.date], label: { Text("Your Birthday") })
                    } footer: {
                        Text("We need your birthday to allow us to calculate your NAPFA Scores. This data will be kept confidential and will not be uploaded to any cloud server.")
                    }

                    
                    Section {
                        Text("2.4KM Run")
                        TextField(String(twoPointFourKMRunScore), text: $twoPointFourKMRun)
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
                        TextField(String(inclinedPullupsScore), text: $inclinedPullups)
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
                        TextField(String(sitUpsScore), text: $sitUps)
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
                if (Float(twoPointFourKMRun) != nil && Float(sitAndReach) != nil && Float(standingBroadJump) != nil && Float(inclinedPullups) != nil && Float(shuttleRun) != nil && Float(sitUps) != nil) {
                    
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



struct HomeView_Previews: PreviewProvider {
    @State static var a = 1
    static var previews: some View {
        HomeView(tabSelection: $a)
    }
}

struct HomeViewModal_Previews: PreviewProvider {
    @State static var a = 1.0
    static var previews: some View {
        getGoalData(twoPointFourKMRunScore: $a, standingBroadJumpScore: $a, inclinedPullupsScore: $a, shuttleRunScore: $a, sitUpsScore: $a, sitAndReachScore: $a)
    }
}
