//
//  WorkoutExerciseView.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 2/11/22.
//

import SwiftUI

struct WorkoutExerciseView: View {
    let exercises: [Exercise]
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State var completedExercises:[Exercise] = []
    @State var isPaused = true
    @State var currentExerciseIndex = 0
    @State var timeRemaining: Double = 3
    @State var started = false
    @State var ended = false
    @State var showEndedDetails = false
    @State var remainingTimePerRep = 0.0
    @State var restart = "false"
    @State var completedReps = 0
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var historyManager = WorkoutHistoryManger()
    
    func restartWorkout() {
        completedExercises = []
        isPaused = true
        currentExerciseIndex = 0
        timeRemaining = 3
        started = false
        ended = false
        showEndedDetails = false
        completedReps = 0
        timer.upstream.autoconnect()
    }
    var body: some View {
        ZStack {
            if started && !ended {
                VStack {
                    HStack {
                        if exercises[currentExerciseIndex].name == "Rest" {
                            CircularProgressViewLarge(progress: timeRemaining/Double(exercises[currentExerciseIndex].duration), refresh: .constant(0))
                        } else {
                            Spacer()
                            CircleProgressBar(
                                totalTime: Double(exercises[currentExerciseIndex].duration),
                                showReps: false,
                                timeRemaining: $timeRemaining,
                                repInfo: .constant("")
                            )
                            Spacer()
                            CircleProgressBar(
                                totalTime: Double(exercises[currentExerciseIndex].duration)/Double(exercises[currentExerciseIndex].reps),
                                showReps: true,
                                timeRemaining: $remainingTimePerRep,
                                repInfo: .constant("\(completedReps)/\(exercises[currentExerciseIndex].reps)")
                            )
                            Spacer()
                        }
                    }
                    Text("\(exercises[currentExerciseIndex].name)")
                        .font(.largeTitle)
                        .padding(.bottom)
                        .onReceive(timer) { _ in
                            if !isPaused && started {
                                if timeRemaining >= 0 {
                                    withAnimation(.linear(duration: 0.1)) {
                                        timeRemaining -= 0.1
                                    }
                                    if exercises[currentExerciseIndex].name != "Rest" {
                                        if remainingTimePerRep <= 0.1 {
                                            remainingTimePerRep = timeRemaining.truncatingRemainder(dividingBy: Double(exercises[currentExerciseIndex].duration/exercises[currentExerciseIndex].reps))
                                        } else {
                                            withAnimation {
                                                remainingTimePerRep = timeRemaining.truncatingRemainder(dividingBy: Double(exercises[currentExerciseIndex].duration/exercises[currentExerciseIndex].reps))
                                            }
                                        }
                                        if remainingTimePerRep <= 0.1 && completedReps <= exercises[currentExerciseIndex].reps {
                                            completedReps += 1
                                            print("kusegklhtjgieh")
                                        }
                                    }
                                } else {
                                    if !ended {
                                        completedExercises.append(exercises[currentExerciseIndex])
                                    }
                                    if currentExerciseIndex < exercises.count-1 {
                                        currentExerciseIndex += 1
                                        completedReps = 0
                                        timeRemaining = Double(exercises[currentExerciseIndex].duration)
                                    } else {
                                        restartWorkout()
                                        ended = true
                                        completedReps = 0
                                        timer.upstream.connect().cancel()
                                    }
                                }
                            }
                        }
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button {
                            if currentExerciseIndex + 1 < exercises.count {
                                currentExerciseIndex += 1
                                timeRemaining = Double(exercises[currentExerciseIndex].duration)
                            } else {
                                restartWorkout()
                                ended = true
                            }
                        } label: {
                            Text("Skip")
                                .frame(maxWidth: UIScreen.main.bounds.width-50, alignment: .center)
                                .padding()
                                .foregroundColor(.white)
                                .background(.blue)
                                .cornerRadius(15)
                        }
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Button {
                            restartWorkout()
                            ended = true
                            timer.upstream.connect().cancel()
                        } label: {
                            Text("End Workout")
                                .frame(maxWidth: UIScreen.main.bounds.width-50, alignment: .center)
                                .padding()
                                .background(.red)
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }
                        Spacer()
                    }
                    .padding(.bottom)
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
            }
            
            if !started {
                VStack {
                    Text(timeRemaining == 0 ? "GO" : String(format: "%.0f", timeRemaining))
                        .font(.largeTitle)
                        .bold()
                        .onReceive(timer) { _ in
                            if timeRemaining > 1 && !started {
                                withAnimation {
                                    timeRemaining -= 0.1
                                }
                            } else {
                                withAnimation {
                                    started = true
                                }
                                timeRemaining = Double(exercises[currentExerciseIndex].duration)
                                isPaused = false
                            }
                        }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(timeRemaining == 0 ? .green : colorScheme == .dark ? .black : .white)
            }
            if ended {
                EndedWorkoutView(restart: $restart, completedExercises: completedExercises, allExercises: exercises)
            }
        }
        .onChange(of: restart) { _ in
            restartWorkout()
        }
        .frame(minHeight: 0, maxHeight: .infinity)
    }
}

struct WorkoutExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutExerciseView(exercises: [Exercise(name: "pushups", duration: 5, reps: 5), Exercise(name: "weeeee", duration: 2, reps: 5)])
        }
    }
}
