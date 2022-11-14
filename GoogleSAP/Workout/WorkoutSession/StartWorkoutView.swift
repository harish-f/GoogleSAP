//
//  WorkingOutView.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 22/10/22.
//

import SwiftUI


extension Date {
    func dayOfWeek() -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"].firstIndex(of: dateFormatter.string(from: self).capitalized)
        // or use capitalized(with: locale) if you want
    }
}

struct WorkingOutHomeView: View {
    let dow = Date().dayOfWeek()!
    @StateObject var routinesManager: RoutinesDataManager
    @State var showAddSheet = false
    @State var showEditSheet = false
    @State var shownExerciseIndex = 0
    var body: some View {
        VStack {
            List {
                ForEach(routinesManager.routines[dow].exercises) { exercise in
                    Button {
                        shownExerciseIndex = routinesManager.routines[dow].exercises.firstIndex(of: exercise)!
                        showEditSheet = true
                    } label: {
                        VStack(alignment: .leading) {
                            Text("\(exercise.name)")
                            Text("\(exercise.reps) reps, \(exercise.duration)s")
                                .font(.caption)
                                .foregroundColor(.black)
                        }
                    }
                }
                .onMove { currIndex, offset in
                    routinesManager.routines[dow].exercises.move(fromOffsets: currIndex, toOffset: offset)
                    
                }
                .onDelete { indexSet in
                    routinesManager.routines[dow].exercises.remove(atOffsets: indexSet)
                }
            }
            .toolbar {
                EditButton()
            }
            NavigationLink {
                WorkoutExerciseView(exercises: routinesManager.routines[dow].exercises)
            } label: {
                Text("Start")
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddSheet = true
                } label: {
                    Image(systemName: "plus").tint(.blue)
                }
            }
        }
        .sheet(isPresented: $showEditSheet) {
            EditExerciseView(exercise: $routinesManager.routines[dow].exercises[shownExerciseIndex])
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $showAddSheet) {
            AddExerciseView(exercises: $routinesManager.routines[dow].exercises)
                .presentationDetents([.medium])
        }
        .navigationTitle("Today's workout")
        .onDisappear {
            routinesManager.saveData()
        }
    }
}

//struct WorkingOutHomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            WorkingOutHomeView()
//        }
//    }
//}
