//
//  EditRoutineComponentView.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 12/10/22.
//

// Editing a single component in a routine

import SwiftUI

struct EditExerciseView: View {
    @Binding var exercise: Exercise
    @State var editedExercise: Exercise = Exercise(name: "", duration: 0, reps: 0)
    @State var isRest = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("Edit exercise")
                .font(.title)
                .bold()
                .frame(alignment: .leading)
                .padding()
            Form {
                Section {
                    Toggle("Rest", isOn: $isRest)
                }
                Section {
                    if !isRest {
                        HStack {
                            Text("Name")
                            Spacer()
                            TextField("0", text: $editedExercise.name)
                                .fixedSize()
                        }
                        HStack {
                            Text("Reps")
                            Spacer()
                            TextField("0", value: $editedExercise.reps, format: .number)
                                .keyboardType(.numberPad)
                                .fixedSize()
                        }
                    }
                    HStack {
                        Text("Duration")
                        Spacer()
                        TextField("0", value: $editedExercise.duration, format: .number)
                            .keyboardType(.numberPad)
                            .fixedSize()
                    }
                }
                HStack {
                    Spacer()
                    Button {
                        exercise = editedExercise
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                    .disabled(editedExercise.duration <= 0 || (editedExercise.name == "" || editedExercise.reps <= 0) && !isRest)
                    Spacer()
                }
            }
        }
        .onAppear {
            editedExercise = exercise
            isRest = exercise.name == "Rest"
        }
    }
}

struct EditRoutineComponentView_Previews: PreviewProvider {
    static var previews: some View {
        EditExerciseView(exercise: .constant(Exercise(name: "pushup", duration: 30, reps: 30)))
    }
}
