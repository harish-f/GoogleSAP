//
//  ContentView.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 12/10/22.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.secondarySystemBackground
    }
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            RoutinesView()
                .tabItem {
                    Label("Workout", systemImage: "figure.walk.circle.fill")
                }
            LoggerView()
                .tabItem {
                    Label("Logger", systemImage: "list.number")
                }
            CalculatorStartPageView()
                .tabItem {
                    Label("Calculator", systemImage: "number.circle.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
