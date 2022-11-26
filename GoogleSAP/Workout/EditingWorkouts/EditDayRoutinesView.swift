//
//  EditDayRoutinesView.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 12/10/22.
//

// Page to see all the routines for a specific day

import SwiftUI

struct EditDayRoutinesView: View {
    @Binding var routine: Routine
    @ObservedObject var routinesData: RoutinesDataManager
    @State var showEditSheet = false
    @State var showAddSheet = false
    @State var selectedExerciseIndex = 0
    @State var tempRoutine:Routine = Routine(title: "", exercises: [])
    var body: some View {
        VStack {
            List {
                ForEach(tempRoutine.exercises) { exercise in
                    Button {
                        selectedExerciseIndex = tempRoutine.exercises.firstIndex(of: exercise)!
                        showEditSheet = true
                    } label: {
                        if exercise.name == "Rest" {
                            VStack(alignment: .leading) {
                                Text(exercise.name)
                                Text("\(exercise.duration)s")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        } else {
                            VStack(alignment: .leading) {
                                Text(exercise.name)
                                Text("\(exercise.reps) reps, \(exercise.duration)s")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .onMove { currIndex, offset in
                    tempRoutine.exercises.move(fromOffsets: currIndex, toOffset: offset)
                }
                .onDelete { indexSet in
                    tempRoutine.exercises.remove(at: indexSet.first!)
                }
            }
            .toolbar {
                EditButton()
            }
        }
        .navigationTitle(routine.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddSheet = true
                } label: {
                    Image(systemName: "plus").tint(.blue)
                }
            }
        }
        .onChange(of: tempRoutine.exercises) { _ in
            routine = tempRoutine
            routinesData.saveData()
        }
        .sheet(isPresented: $showEditSheet) {
            EditExerciseView(exercise: $tempRoutine.exercises[selectedExerciseIndex])
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $showAddSheet) {
            AddExerciseView(exercises: $tempRoutine.exercises)
                .presentationDetents([.medium])
        }
        .onAppear {
            tempRoutine = routine
        }
    }
}

//struct EditDayRoutinesView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            EditDayRoutinesView(routine: .constant(Routine(title: "Monday", exercises: [Exercise(name: "pushup", duration: 30, reps: 30)])))}
//    }
//}
