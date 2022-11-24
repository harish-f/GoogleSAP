//
//  EndedWorkoutView.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 23/11/22.
//

import SwiftUI

struct EndedWorkoutView: View {
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    @StateObject var historyManager = WorkoutHistoryManger()
    
    @Binding var restart: String
    @State var showDetails = false
    var completedExercises: [Exercise]
    var allExercises: [Exercise]
    var body: some View {
        ZStack {
            VStack {
                Text("Workout Ended")
                Text("Great Job!")
                List(allExercises) {exercise in
                    HStack {
                        Image(systemName: completedExercises.contains(exercise) ? "checkmark" : "xmark")
                            .foregroundColor(completedExercises.contains(exercise) ? .green : .red)
                        Text(exercise.name)
                    }
                }
            }
            VStack {
                Spacer()
                Button {
                    restart = restart == "true" ? "false" : "true"
                } label: {
                    Text("Restart")
                        .padding(10)
                        .padding(.horizontal)
                        .background(.blue)
                        .cornerRadius(15)
                        .foregroundColor(.white)
                        .padding(.bottom)
                }
            }.onAppear {
                historyManager.workoutHistory.append(WorkoutSession(exercises: completedExercises, date: Date.now))
                historyManager.saveData()
            }
        }
        .onReceive(timer) { _ in
            showDetails = true
            timer.upstream.connect().cancel()
        }
    }
}

