//
//  ExplanationsView.swift
//  PIMonteCarlo
//
//  Created by Rémy Castro on 08/01/2024.
//

import SwiftUI

struct ExplanationsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Application PI Monte Carlo")
                    .font(.title)
                    .fontWeight(.bold)
                    .underline()
                
                Text("Application réalisée en SWIFT UI dans le cadre de la deuxième année de master MIAGE.\n\nAuteur : Rémy Castro")
                
                Text("Fonctionnalités Principales")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("1. Approximation de PI")
                    .font(.headline)
                
                Text("Dans l'onglet principal (\(Image(systemName: "house.fill"))), vous avez la possibilité de calculer une approximation de PI avec un graphique contenant un arc de cercle.")
                Text("Pour calculer, il suffit de déplacer le slider, qui lancera un calcul après l'avoir relâcher, ou de cliquer sur '\(Image(systemName: "bolt.fill")) Lancer le calcul' pour le relancer avec le même nombre de points.")
                
                Text("2. Statistiques")
                    .font(.headline)
                
                Text("Lorsque vous avez lancer plusieurs calculs, l'onglet statistiques (\(Image(systemName: "chart.bar"))) vous permet de comparer les résultats obtenus pour chaque nombre de points.")
                Text("En haut, vous avez la meilleure approximation de PI obtenue avec son nombre de points. Et en dessous, un graphique qui montre le meilleur résultat pour chaque nombre de points testé. La ligne rouge représente π. ")
                Text("Enfin, vous avez la possibilité de réinitialiser les statistiques avec le bouton '\(Image(systemName: "trash")) Supprimer tous les résultats' ")
                
                Text("Architecture")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Architecture utilisée : MVC")
                Text("Graphique de monte carlo : /Views/Components/PointsView")
                Text("Sauvegarde des données : Core Data")
            }
            .padding(.bottom, 100)
        }
    }
}

#Preview {
    ExplanationsView()
}
