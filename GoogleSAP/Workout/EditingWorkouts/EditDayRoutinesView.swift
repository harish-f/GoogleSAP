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
    var body: some View {
        VStack {
            List {
                ForEach(routine.exercises) { exercise in
                    Button {
                        selectedExerciseIndex = routine.exercises.firstIndex(of: exercise)!
                        showEditSheet = true
                    } label: {
                        VStack(alignment: .leading) {
                            Text(exercise.name)
                            Text("\(exercise.reps) reps, \(exercise.duration)s")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onMove { currIndex, offset in
                    routine.exercises.move(fromOffsets: currIndex, toOffset: offset)
                }
                .onDelete { indexSet in
                    routine.exercises.remove(at: indexSet.first!)
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
        .onChange(of: routine.exercises) { _ in
            routinesData.saveData()
        }
        .sheet(isPresented: $showEditSheet) {
            EditExerciseView(exercise: $routine.exercises[selectedExerciseIndex])
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $showAddSheet) {
            AddExerciseView(exercises: $routine.exercises)
                .presentationDetents([.medium])
        }
    }
}

//struct EditDayRoutinesView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            EditDayRoutinesView(routine: .constant(Routine(title: "Monday", exercises: [Exercise(name: "pushup", duration: 30, reps: 30)])))}
//    }
//}
