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
    
    //    func doubleMod()
    
    @ObservedObject var historyManager = WorkoutHistoryManger()
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    CircleProgressBar(totalTime: Double(exercises[currentExerciseIndex].duration), showReps: false, timeRemaining: timeRemaining, repInfo: "jhgk")
                    Spacer()
                    CircleProgressBar(totalTime: Double(exercises[currentExerciseIndex].duration)/Double(exercises[currentExerciseIndex].reps), showReps: true, timeRemaining: timeRemaining, repInfo: "jhgk")
                    Spacer()
                }
                
                Text("\(exercises[currentExerciseIndex].name)")
                Text("\(timeRemaining)")
                    .onReceive(timer) { _ in
                        if !isPaused && started {
                            if timeRemaining > 0 {
                                withAnimation(.linear(duration: 0.1)) {
                                    timeRemaining -= 0.1
                                    remainingTimePerRep = timeRemaining.truncatingRemainder(dividingBy: Double(exercises[currentExerciseIndex].duration/exercises[currentExerciseIndex].reps))
                                }
                            } else {
                                if !ended {
                                    completedExercises.append(exercises[currentExerciseIndex])
                                }
                                if currentExerciseIndex < exercises.count-1 {
                                    currentExerciseIndex += 1
                                    timeRemaining = Double(exercises[currentExerciseIndex].duration)
                                } else {
                                    ended = true
                                    timer.upstream.connect().cancel()
                                }
                            }
                            
                        }
                    }
                Spacer()
                Form {
                    Section{
                        HStack{
                            Spacer()
                            Button {
                                if currentExerciseIndex + 1 < exercises.count {
                                    currentExerciseIndex += 1
                                    timeRemaining = Double(exercises[currentExerciseIndex].duration)
                                } else {
                                    ended = true
                                }
                            } label: {
                                Text("Skip")
                                    .foregroundColor(.red)
                            }
                            Spacer()
                        }
                    }
                    Section {
                        HStack {
                            Spacer()
                            Button {
                                
                            } label: {
                                Text("End Workout")
                                    .foregroundColor(.white)
                            }
                            Spacer()
                        }
                    }
                    .listRowBackground(Color.red)
                }
            }
            .toolbar {
                Button {
                    withAnimation {
                        isPaused.toggle()
                    }
                } label: {
                    Image(systemName: isPaused ? "play.fill" : "pause.fill")
                }
            }
            
            
            if !started {
                VStack {
                    Text(timeRemaining == 0 ? "GO" : String(format: "%.0f", timeRemaining))
                        .font(.title)
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
                .background(timeRemaining == 0 ? .green : .white)
            }
            if ended {
                VStack {
                    Text("Workout Ended")
                    Text("Great Job!")
                    List(exercises) { exercise in
                        HStack {
                            Image(systemName: completedExercises.contains(exercise) ? "checkmark" : "xmark")
                                .foregroundColor(completedExercises.contains(exercise) ? .green : .red)
                            Text(exercise.name)
                        }
                    }
                    Form {
                        Button {
                            completedExercises = []
                            isPaused = true
                            currentExerciseIndex = 0
                            timeRemaining = 3
                            started = false
                            ended = false
                            showEndedDetails = false
                            timer.upstream.autoconnect()
                        } label: {
                            Text("Restart")
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
