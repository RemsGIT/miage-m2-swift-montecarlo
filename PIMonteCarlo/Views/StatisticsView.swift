//
//  StatisticsView.swift
//  PIMonteCarlo
//
//  Created by Rémy Castro on 19/12/2023.
//

import SwiftUI
import Charts

struct StatisticsView: View {
    @StateObject private var controller = MonteCarloController()
    @State private var refreshView = false
    
    
    var body: some View {
        GeometryReader { geometry in
            // Responsive
            let smallScreen = geometry.size.width < 600
            
            let isIpad = geometry.size.width > 700 && geometry.size.height > 500
            let layout = smallScreen ? AnyLayout(VStackLayout()) : AnyLayout(HStackLayout())
                        
            layout() {
                if let bestResult = controller.getBestResultFromPI() {
                    
                    if(!smallScreen) {
                        VStack {
                            Text("Meilleur résultat: \(bestResult.result) avec \(bestResult.points) points")
                            DeleteResultsButton(refreshView: $refreshView, controller: controller)
                        }
                    }
                    else {
                        Text("Meilleur résultat: \(bestResult.result) avec \(bestResult.points) points")
                    }

                    if let bestResults = controller.getAllBestResults() {
                        let points = bestResults.map { $0.points }
                        let results = bestResults.map { $0.result }

                        let minX = points.min() ?? 0
                        let maxX = points.max() ?? 1
                        let minY = bestResults.count > 1 ? results.min() ?? 1 : (results.min() ?? 1) - 0.1
                        let maxY = bestResults.count > 1 ? results.max() ?? 1 : (results.max() ?? 1) + 0.1

                        Chart {
                            ForEach(bestResults, id: \.points) { result in
                                LineMark(
                                    x: .value("Nombre de points", result.points),
                                    y: .value("Résultat", result.result)
                                )
                            }
                            RuleMark(y: .value("Valeur de PI", Double.pi))
                                        .foregroundStyle(.red)
                        }
                        .frame(height: !smallScreen ? isIpad ? 400 : 150 : 300)
                        .chartXAxis {
                            AxisMarks(values: bestResults.map { Double($0.points) })
                        }
                        .chartXScale(domain: [minX,maxX])
                        .chartYScale(domain: [minY,maxY])
                        .padding()

                    }
                }
                else {
                    Text("Lancer plusieurs calcul pour voir les statistiques")
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                if(smallScreen && controller.getBestResultFromPI() != nil) {
                    DeleteResultsButton(refreshView: $refreshView, controller: controller)
                    .padding(.top, smallScreen ? 100 : 20)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            
        }
        .id(refreshView)
    }
}

struct DeleteResultsButton: View {
    @Binding var refreshView: Bool
    @ObservedObject var controller: MonteCarloController
    
    var body: some View {
        Button(action: {
            controller.deleteAllBestResults()
            refreshView.toggle()
        }) {
            Label("Supprimer tous les résultats", systemImage: "trash")
        }
        .buttonStyle(.bordered)
    }
}


#Preview {
    StatisticsView()
}
