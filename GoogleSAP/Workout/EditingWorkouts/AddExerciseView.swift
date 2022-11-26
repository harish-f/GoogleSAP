//
//  AddExerciseView.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 18/10/22.
//

import SwiftUI

struct AddExerciseView: View {
    @Binding var exercises: [Exercise]
    @State var newExercise = Exercise(name: "Name", duration: 0, reps: 0)
    @State var repSelection = 0
    @State var isRest = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("Add exercise")
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
                            TextField("0", text: $newExercise.name)
                                .fixedSize()
                        }
                        HStack {
                            Text("Reps")
                            Spacer()
                            TextField("0", value: $newExercise.reps, format: .number)
                                .keyboardType(.numberPad)
                                .fixedSize()
                        }
                    }
                    HStack {
                        Text("Duration")
                        Spacer()
                        TextField("0", value: $newExercise.duration, format: .number)
                            .keyboardType(.numberPad)
                            .fixedSize()
                    }
                }
                
                Section {
                    Button {
                        if isRest {
                            newExercise.name = "Rest"
                            newExercise.reps = 1
                        }
                        exercises.append(newExercise)
                        dismiss()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Done")
                            Spacer()
                        }
                    }
                    .disabled(newExercise.duration <= 0 || (newExercise.name == "" || newExercise.reps <= 0) && !isRest)
                }
            }
        }
    }
}

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseView(exercises: .constant([Exercise(name: "test", duration: 0, reps: 0)]))
    }
}
