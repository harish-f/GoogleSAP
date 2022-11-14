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
                    HStack {
                        Text("Name")
                        Spacer()
                        TextField("0", text: $exercise.name)
                            .fixedSize()
                    }
                    HStack {
                        Text("Duration")
                        Spacer()
                        TextField("0", value: $exercise.duration, format: .number)
                            .keyboardType(.numberPad)
                            .fixedSize()
                    }
                    HStack {
                        Text("Reps")
                        Spacer()
                        TextField("0", value: $exercise.reps, format: .number)
                            .keyboardType(.numberPad)
                            .fixedSize()
                    }
                }
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                    Spacer()
                }
            }
        }
    }
}

struct EditRoutineComponentView_Previews: PreviewProvider {
    static var previews: some View {
        EditExerciseView(exercise: .constant(Exercise(name: "pushup", duration: 30, reps: 30)))
    }
}
