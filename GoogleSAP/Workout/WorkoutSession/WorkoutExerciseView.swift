//
//  WorkoutExerciseView.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 2/11/22.
//

import SwiftUI

struct WorkoutExerciseView: View {
    let exercises: [Exercise]
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var completedExercises:[Exercise] = []
    @State var isPaused = true
    @State var currentExerciseIndex = 0
    @State var timeRemaining = 3
    @State var started = false
    @State var ended = false
    @State var showEndedDetails = false
    
    
    @ObservedObject var historyManager = WorkoutHistoryManger()
    var body: some View {
        ZStack {
            VStack {
                TimerBar(totalTime: Double(exercises[currentExerciseIndex].duration), timeRemaining: $timeRemaining)
                HStack {
                    Spacer()
                    Button {
                        if currentExerciseIndex + 1 < exercises.count {
                            currentExerciseIndex += 1
                            timeRemaining = exercises[currentExerciseIndex].duration
                        } else {
                            ended = true
                        }
                    } label: {
                        Text("Skip")
                            .foregroundColor(.red)
                    }
                }
                Text("\(exercises[currentExerciseIndex].name)")
                Text("\(timeRemaining)")
                    .onReceive(timer) { _ in
                        if !isPaused && started {
                            if timeRemaining > 0 {
                                withAnimation(.linear(duration: 1.0)) {
                                    timeRemaining -= 1
                                }
                            } else {
                                if !ended {
                                    completedExercises.append(exercises[currentExerciseIndex])
                                }
                                if currentExerciseIndex < exercises.count-1 {
                                    currentExerciseIndex += 1
                                    timeRemaining = exercises[currentExerciseIndex].duration
                                } else {
                                    ended = true
                                    timer.upstream.connect().cancel()
                                }
                            }
                            
                        }
                    }
            }
            .toolbar {
                Button {
                    withAnimation {
                        isPaused = !isPaused
                    }
                } label: {
                    Image(systemName: isPaused ? "play.fill" : "pause.fill")
                }
            }
            if !started {
                VStack {
                    Text(timeRemaining == 0 ? "GO" : "\(timeRemaining)")
                        .font(.title)
                        .onReceive(timer) { _ in
                            if timeRemaining > 0 && !started {
                                withAnimation {
                                    timeRemaining -= 1
                                }
                            } else {
                                started = true
                                timeRemaining = exercises[currentExerciseIndex].duration
                                isPaused = false
                            }
                        }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(timeRemaining == 0 ? .green : .white)
            }
            if ended {
                VStack {
                    Text("Workout Ended")
                    Text("Great Job!")
                    List(exercises) { exercise in
                        HStack {
                            Image(systemName: completedExercises.contains(exercise) ? "xmark" : "checkmark")
                                .foregroundColor(completedExercises.contains(exercise) ? .red : .green)
                            Text(exercise.name)
                        }
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(.white)
                .onAppear {
                    historyManager.workoutHistory.append(WorkoutSession(exercises: completedExercises, date: Date.now))
                    historyManager.saveData()
                }
            }
        }
    }
}

struct WorkoutExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutExerciseView(exercises: [Exercise(name: "pushups", duration: 5, reps: 5), Exercise(name: "weeeee", duration: 2, reps: 5)])
        }
    }
}
