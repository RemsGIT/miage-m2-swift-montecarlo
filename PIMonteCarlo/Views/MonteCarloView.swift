//
//  MonteCarloView.swift
//  PIMonteCarlo
//
//  Created by Rémy Castro on 19/12/2023.
//

import SwiftUI

struct MonteCarloView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @StateObject private var controller = MonteCarloController()
    

    var body: some View {
        GeometryReader { geometry in

            // Responsive
            let smallScreen = geometry.size.width < 600
            
            let isIpad = geometry.size.width > 700 && geometry.size.height > 500
            let layout = smallScreen ? AnyLayout(VStackLayout()) : AnyLayout(HStackLayout())

            layout {
                PointsView(points: controller.points)
                    .frame(height: smallScreen ? 350 : isIpad ? 500 : 200)
                    .border(Color.gray, width: 1)
                    .padding()
                
                VStack {
                    Text("Nombre de points: \(Int(controller.totalPoints) )")
                    
                    Slider(value: $controller.totalPoints, in: 10000...100000, step: 1000) { startChanging in
                            if !startChanging {
                                controller.runMonteCarloSimulation()
                            }
                        }
                        .padding()
                    
                    Text("Approximation de π: \(controller.piApproximation)")
                        
                    Button(action: controller.runMonteCarloSimulation) {
                        Label("Lancer le calcul", systemImage: "bolt.fill")
                        
                    }
                    .buttonStyle(.bordered)
                    .padding()
                    
                }
            }
        }
        
    }
}

#Preview {
    MonteCarloView()
}
