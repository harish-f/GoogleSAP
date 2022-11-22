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
    
    // TODO: MAKE THESE A(HIGHEST) SCORES ADAPT TO USER AGE
    @State var TwoPointFourKMRunHighestScore = 641.0
    @State var ShuttleRunHighestScore = 10.2
    @State var SitUpsHighestScore = 42.0
    @State var SitAndReachHighestScore = 45.0
    @State var InclinedPullupsHighestScore = 7.0
    @State var StandingBroadJumpHighestScore = 237.0
    
    // TODO: MAKE THIS TAKE FROM PERSISTENCE AND AUTOUPDATE BASED ON BDAY
    @State var age = 16
    
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
//                                            .padding(.bottom, geometry.size.height * 0.03)
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
                                    .onAppear {
                                        if (autoScroll) {
//                                            print("aaa")
//                                            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//                                                withAnimation {
//                                                    proxy.scrollTo(idGen(text: data[(data.firstIndex(of: datum)! + 1) > 5 ? 0 : data.firstIndex(of: datum)! + 1].text))
//                                                }
//                                            }
//                                            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0*2) {
//                                                print("a")
//                                                withAnimation {
//                                                    proxy.scrollTo(idGen(text: data[(data.firstIndex(of: datum)! + 2) > 5 ? 0 : data.firstIndex(of: datum)! + 2].text))
//                                                }
//                                            }
//                                            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0*3) {
//                                                withAnimation {
//                                                    proxy.scrollTo(idGen(text: data[(data.firstIndex(of: datum)! + 3) > 5 ? 0 : data.firstIndex(of: datum)! + 3].text))
//                                                }
//                                            }
//                                            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0*4) {
//                                                withAnimation {
//                                                    proxy.scrollTo(idGen(text: data[(data.firstIndex(of: datum)! + 4) > 5 ? 0 : data.firstIndex(of: datum)! + 4].text))
//                                                }
//                                            }
//                                            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0*5) {
//                                                withAnimation {
//                                                    proxy.scrollTo(idGen(text: data[(data.firstIndex(of: datum)! + 5) > 5 ? 0 : data.firstIndex(of: datum)! + 4].text))
//                                                }
//                                            }
//                                            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0*6) {
//                                                withAnimation {
//                                                    proxy.scrollTo(idGen(text: data[(data.firstIndex(of: datum)! + 6) > 5 ? 0 : data.firstIndex(of: datum)! + 6].text))
//                                                }
//                                            }
                                        }
                                    }
                                    
                                    Spacer()
                                        .scrollSnappingAnchor(.bounds)
                                        .id(idGen(text: datum.text))
                                }
                                
                            }
                            .padding(.bottom, sizeOfBigProgress * 0.000)
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
                                    self.tabSelection = 1
                                }
                                Button("Go to Logger") {
                                    self.tabSelection = 2
                                }
                                Button("Go to Calculator") {
                                    self.tabSelection = 3
                                }
                            }
                        }
                        .padding(.top, sizeOfBigProgress * 0.00)
                        .sheet(isPresented: $showModal) {
                            showModal = false
                        } content: {
                            getGoalData()
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
                        TextField("Seconds", text: $twoPointFourKMRun)
                            .keyboardType(.numberPad)
                    }
                    Section {
                        Text("Sit And Reach")
                        TextField("CM", text: $sitAndReach)
                            .keyboardType(.numberPad)
                    }
                    Section {
                        Text("Standing Broad Jump")
                        TextField("CM", text: $standingBroadJump)
                            .keyboardType(.numberPad)
                    }
                    Section {
                        Text("Inclined Pullups (In 30 seconds)")
                        TextField("Reps", text: $inclinedPullups)
                            .keyboardType(.numberPad)
                    }
                    Section {
                        Text("Shuttle Run")
                        TextField("Seconds", text: $shuttleRun)
                            .keyboardType(.numberPad)
                    }
                    Section {
                        Text("Situps (In 1 min)")
                        TextField("Reps", text: $sitUps)
                            .keyboardType(.numberPad)
                    }
                }
            }
            .navigationTitle("Set Your Goals")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button {
                dismiss()
            } label: {Text("Cancel").foregroundColor(.red)})
            
            .navigationBarItems(trailing: Button {
                dismiss()
            } label: {Text("Set").foregroundColor(.blue)})
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
    static var previews: some View {
        getGoalData()
    }
}
