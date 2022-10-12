//
//  ContentView.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 12/10/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RoutinesView()
                .tabItem {
                    Label("Workout", systemImage: "figure.walk.circle.fill")
                }
            LoggerView()
                .tabItem {
                    Label("Logger", systemImage: "list.number")
                }
            CalculatorView()
                .tabItem {
                    Label("Calculator", systemImage: "number.circle.fill")
                }
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
