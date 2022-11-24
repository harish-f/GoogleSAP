//
//  ContentView.swift
//  GoogleSAP
//
//  Created by HARISH RAM BAGHAVATH stu on 12/10/22.
//

import SwiftUI

struct ContentView: View {
    @State var tabSelect = 0
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.secondarySystemBackground
    }
    
    var body: some View {
        TabView(selection: $tabSelect) {
            HomeView(tabSelection: $tabSelect)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            RoutinesView()
                .tabItem {
                    Label("Workout", systemImage: "figure.walk.circle.fill")
                }
                .tag(1)
            LoggerView()
                .tabItem {
                    Label("Logger", systemImage: "list.number")
                }
                .tag(2)
            CalculatorStartPageView()
                .tabItem {
                    Label("Calculator", systemImage: "number.circle.fill")
                }.tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
