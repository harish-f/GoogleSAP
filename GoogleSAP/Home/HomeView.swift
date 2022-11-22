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
    
    // TODO: MAKE THIS TAKE FROM PERSISTENCE AND AUTOUPDATE BASED ON BDAY
    @State var age = 16
    @State var TwoPointFourKMRunUserSetScore = 641.0
    @State var ShuttleRunUserSetScore = 10.2
    @State var SitUpsUserSetScore = 42.0
    @State var SitAndReachUserSetScore = 45.0
    @State var InclinedPullupsUserSetScore = 7.0
    @State var StandingBroadJumpUserSetScore = 237.0
    
    
    // TODO: MAKE THESE A(HIGHEST) SCORES ADAPT TO USER AGE
    @State var TwoPointFourKMRunHighestScore = 0.0
    @State var ShuttleRunHighestScore = 0.0
    @State var SitUpsHighestScore = 0.0
    @State var SitAndReachHighestScore = 0.0
    @State var InclinedPullupsHighestScore = 0.0
    @State var StandingBroadJumpHighestScore = 0.0
    
    
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
//                                    Spacer()
//                                    Spacer()
                                    
                                    
//                                    HStack(alignment: .center) {
//                                        VStack(alignment: .center) {
//                                            CircularProgressViewLargeIcon(progress: datum.fractionWorkout, sfSymbolName: "target", content: {
//                                                CircularProgressViewLargeIcon(progress: datum.fractionNAPFA, sfSymbolName: "a.circle", content: {
//                                                    Button {
//                                                        proxy.scrollTo(idGen(text: datum.text))
//                                                    } label: {
//                                                        Text(datum.text).font(.title3)
//                                                    }
//                                                })
//                                                .padding(45)
//                                            })
//                                            .frame(width:UIScreen.main.bounds.width-50, height: UIScreen.main.bounds.width-50, alignment: .center)
//                                        }
//                                    }
//                                    .padding(.top, 10)
//                                    .padding()
//                                    .background(
//                                        GeometryReader { geometryProxy in
//                                            Color.clear
//                                                .onAppear {
//                                                    sizeOfBigProgress = geometryProxy.size.height
//                                                }
//                                        }
//                                    )
                                    
                                    HStack(alignment: .center) {
                                        VStack(alignment: .center) {
                                            CircularProgressViewLargeIcon(progress: datum.fractionWorkoutForUserGoal, sfSymbolName: "target", content: {
                                                CircularProgressViewLargeIcon(progress: datum.fractionWorkoutForA, sfSymbolName: "a.circle", content: {
                                                    Button {
                                                        proxy.scrollTo(idGen(text: datum.text))
                                                    } label: {
                                                        Text(datum.text).font(.title3)
                                                    }
                                                })
                                                .padding(45)
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
                            getGoalData(age: $age, twoPointFourKMRunScore: $TwoPointFourKMRunUserSetScore, standingBroadJumpScore: $StandingBroadJumpUserSetScore, inclinedPullupsScore: $InclinedPullupsUserSetScore, shuttleRunScore: $ShuttleRunUserSetScore, sitUpsScore: $SitUpsUserSetScore, sitAndReachScore: $SitAndReachUserSetScore)
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
                        .navigationBarItems(leading:Text("Age: " + String(Int(age))))
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
        }
    }
}


struct getGoalData: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var age: Int
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
                if (Float(twoPointFourKMRun) != nil && Float(sitAndReach) != nil && Float(standingBroadJump) != nil && Float(inclinedPullups) != nil && Float(shuttleRun) != nil && Float(sitUps) != nil) {
                    twoPointFourKMRunScore = Double(twoPointFourKMRun) ?? 0
                    standingBroadJumpScore = Double(standingBroadJump) ?? 0
                    inclinedPullupsScore = Double(inclinedPullups) ?? 0
                    shuttleRunScore = Double(shuttleRun) ?? 0
                    sitUpsScore = Double(sitUps) ?? 0
                    sitAndReachScore = Double(sitAndReach) ?? 0
                    
                    let calendar = Calendar.current
                    let ageComponents = calendar.dateComponents([.year], from: birthdate, to: Date())
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



struct HomeView_Previews: PreviewProvider {
    @State static var a = 1
    static var previews: some View {
        HomeView(tabSelection: $a)
    }
}

struct HomeViewModal_Previews: PreviewProvider {
    @State static var a = 1.0
    @State static var b = 1
    static var previews: some View {
        getGoalData(age: $b, twoPointFourKMRunScore: $a, standingBroadJumpScore: $a, inclinedPullupsScore: $a, shuttleRunScore: $a, sitUpsScore: $a, sitAndReachScore: $a)
    }
}
