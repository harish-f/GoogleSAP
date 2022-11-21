//
//  LoggerView.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 12/10/22.
//

import SwiftUI

struct LoggerView: View {
    @ObservedObject var loggerHistoryManager = LoggerDataManager()
    
    // Tracks what type of logs the user wants to see (custom workouts or napfa scores)
    @State var loggedType = "NAPFA"
    @State var showNewLogCreationSheet = false
    @State var triggerReload = false
    
    // TODO: MAKE IT OBTAIN FROM PERSISTENCE
    @State var data: [LogRecord] = []
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    List(loggerHistoryManager.logRecords) { datum in
                        
                        if ((loggedType == "NAPFA") && (datum.napfaOrWorkout == "Napfa")) {
                            NavigationLink {
                                LogDetailedView(datum: datum)
                            } label: {
                                LoggerMenuItem(date: datum.date, description: datum.description)
                            }
                        } else {
                            EmptyView()
                        }
                        
                        if ((loggedType == "Workouts") && (datum.napfaOrWorkout == "workout")) {
                            NavigationLink {
                                LogDetailedView(datum: datum)
                            } label: {
                                LoggerMenuItem(date: datum.date, description: datum.description)
                            }
                        } else {
                            EmptyView()
                        }
                    }
                }
            }
            .onAppear {
                data = loggerHistoryManager.logRecords
            }
            .onChange(of: data) {_ in
                loggerHistoryManager.logRecords = data
                loggerHistoryManager.saveData()
                
            }
            .navigationTitle("Logger")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showNewLogCreationSheet) {
                CreateNewLogView(data: $data)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNewLogCreationSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Picker(selection: $loggedType, label: Text("Selection")) {
                        Text("NAPFA").tag("NAPFA")
                        Text("Workouts").tag("Workouts")
                    }
                }
            }
        }
    }
}

struct CreateNewLogView: View {
    @Environment(\.dismiss) var dismiss
    // In this case this variable states for which category the user wishes to put that entry in
    @State var loggedType = "NAPFA"
    
    @Binding var data: Array<LogRecord>
//    @ObservedObject var loggerHistoryManager = LoggerDataManager()
    // This is more data from the user
    @State var descriptionOfLog = "Your Description Goes here..."
    @State var date: Date = Date()
    @State var twoPointFourKMRun = ""
    @State var standingBroadJump = ""
    @State var inclinedPullups = ""
    @State var shuttleRun = ""
    @State var sitUps = ""
    @State var sitAndReach = ""
    
    // To inform user that any data entered cannot be used (because not a number, blank etc)
    @State var showAlert = false
    
    var body: some View {
        NavigationView {
            HStack {
                Form {
                    Section {
                        Picker(selection: $loggedType, label: Text("Where")) {
                            Text("NAPFA").tag("NAPFA")
                            Text("Workouts").tag("Workouts")
                        }
                        TextEditor(text: $descriptionOfLog)
                        DatePicker(selection: $date, displayedComponents: .date, label: { Text("Date") })
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
                        Text("Inclined Pullups")
                        TextField("Reps", text: $inclinedPullups)
                            .keyboardType(.numberPad)
                    }
                    Section {
                        Text("Shuttle Run")
                        TextField("Seconds", text: $shuttleRun)
                            .keyboardType(.numberPad)
                    }
                    Section {
                        Text("Situps")
                        TextField("Reps", text: $sitUps)
                            .keyboardType(.numberPad)
                    }
                }
            }
//            .onAppear {
//                loggerHistoryManager.loadData()
//            }
            .navigationTitle("Create New Log")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                            if (Float(twoPointFourKMRun) != nil && Float(sitAndReach) != nil && Float(standingBroadJump) != nil && Float(inclinedPullups) != nil && Float(shuttleRun) != nil && Float(sitUps) != nil) {
                                if (loggedType == "NAPFA") {
                                    data.append(LogRecord(NapfaOrWorkouts: .napfa, description: descriptionOfLog, date: date, twoPointFourKMRun: twoPointFourKMRun, shuttleRun: shuttleRun, sitUps: sitUps, sitAndReach: sitAndReach, inclinedPullups: inclinedPullups, standingBroadJump: standingBroadJump))
                                    dismiss()
                                } else {
                                    data.append(LogRecord(NapfaOrWorkouts: .workout, description: descriptionOfLog, date: date, twoPointFourKMRun: twoPointFourKMRun, shuttleRun: shuttleRun, sitUps: sitUps, sitAndReach: sitAndReach, inclinedPullups: inclinedPullups, standingBroadJump: standingBroadJump))
                                    dismiss()
                                }
                            } else {
                                showAlert = true
                            }
                            
                    } label: {
                        // TODO: MAKE IT ADD BACK TO PERSISTENCE
                        Text("Add")
                    }
                }
            }
        }.alert("Error!", isPresented: $showAlert) {
            Button("Ok") {
                
            }
        } message: {
            Text("Please ensure that the values entered are numbers and are not left blank.")
        }
    }
}

struct LogDetailedView: View {
    var datum: LogRecord
    
    var body: some View {
        Form {
            Section {
                Text(datum.description)
            }
            Section {
                Text("2.4KM Run: " + datum.twoPointFourKMRun)
                Text("Shuttle Run: " + datum.shuttleRun)
                Text("Situps: " + datum.sitUps)
                Text("Sit and Reach: " + datum.sitAndReach)
                Text("Inclined Pullups: " + datum.inclinedPullups)
                Text("Standing Broad Jump: " + datum.standingBroadJump)
            }
        }.navigationTitle(datum.date.formatted(date: .long, time: .omitted))
    }
}


struct LoggerView_Previews: PreviewProvider {
    static var previews: some View {
        LoggerView()
    }
}
