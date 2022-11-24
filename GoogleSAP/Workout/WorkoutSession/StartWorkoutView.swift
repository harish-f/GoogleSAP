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
    @State var startWorkout = false
    @State var notEnoughExercises = false
    var body: some View {
        ZStack{
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
            }
            VStack {
                Spacer()
                Button {
                    if routinesManager.routines[dow].exercises.count > 0 {
                        startWorkout = true
                    } else {
                        notEnoughExercises = true
                    }
                } label: {
                    Text("Start")
                        .padding(10)
                        .padding(.leading)
                        .padding(.trailing)
                        .background(.blue)
                        .cornerRadius(15)
                        .foregroundColor(.white)
                        .padding(.bottom)
                }
            }
            NavigationLink(isActive: $startWorkout) {
                WorkoutExerciseView(exercises: routinesManager.routines[dow].exercises)
            } label: {EmptyView()}
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
        .alert(isPresented: $notEnoughExercises) {
            Alert(title: Text("Unable to start workout!"), message: Text("Add at least 1 exercise to start your workout"), dismissButton: .default(Text("Got it!")))
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
