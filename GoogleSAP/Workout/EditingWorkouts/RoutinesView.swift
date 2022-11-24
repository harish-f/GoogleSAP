//
//  RoutinesView.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 12/10/22.
//

// Page to see all the routines for the entire week

import SwiftUI

struct RoutinesView: View {
    @StateObject var routinesData = RoutinesDataManager()
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    List($routinesData.routines) { $routine in
                        NavigationLink {
                            EditDayRoutinesView(routine: $routine, routinesData: routinesData)
                        } label: {
                            Text("\(routine.title)")
                        }
                    }
                }
                VStack{
                    Spacer()
                    NavigationLink {
                        WorkingOutHomeView(routinesManager: routinesData)
                    } label: {
                        VStack {
                            Text("Start Workout")
                                .padding(10)
                                .background(.blue)
                                .cornerRadius(15)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.bottom)
                }
                
            }
            .navigationTitle("Workouts")
        }
    }
}

struct RoutinesView_Previews: PreviewProvider {
    static var previews: some View {
        RoutinesView()
    }
}
