//
//  ContentView.swift
//  PIMonteCarlo
//
//  Created by Rémy Castro on 17/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .house
    
    // Responsive
    let orientationNotification = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
    @State private var orientation: UIDeviceOrientation?
    
    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        ZStack {
            VStack {
                switch selectedTab {
                case .house:
                    MonteCarloView()
                case .statistics:
                    StatisticsView()
                case .description:
                    ExplanationsView()
                }
            }
            .padding()
            VStack {
                Spacer()
                BottomBar(selectedTab: $selectedTab)
            }
        }
    }

}



#Preview {
    ContentView()
}
