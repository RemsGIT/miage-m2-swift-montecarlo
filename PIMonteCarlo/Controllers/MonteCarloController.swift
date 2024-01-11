import SwiftUI
import CoreData


class MonteCarloController: ObservableObject {
    @Published var totalPoints: Double = 1000
    @Published var points: [MonteCarloPoint] = []
    
    @Published var insideCircle: Int = 0
    @Published var piApproximation: CGFloat = 0.0

    
    @Published var models = [BestResultItem]()

    let context = DataManager.shared.managedObjectContext

    func runMonteCarloSimulation() {
        print("start montecarlo")
        
        points.removeAll()
        insideCircle = 0
        
        var newPoints = [MonteCarloPoint]()
        
        for _ in 0..<Int(totalPoints) {
            let randomX = CGFloat(Float.random(in: 0.0..<1.0))
            let randomY = CGFloat(Float.random(in: 0.0..<1.0))

            let distance = sqrt(pow(randomX, 2) + pow(randomY, 2))
            
            let pointIsInsideCircle = distance <= 1.0
            
            if pointIsInsideCircle {
                insideCircle+=1
            }
            
            newPoints.append(MonteCarloPoint(x: randomX, y: randomY, insideCircle: pointIsInsideCircle))
        }
        
        points.append(contentsOf: newPoints)
        piApproximation = 4 * CGFloat(insideCircle) / totalPoints
        
        saveResultToCoreData(result: piApproximation)
        print("end montecarlo")
    }
        
    func getBestResultFromPI() -> BestResultItem? {
        do {
            let fetchRequest: NSFetchRequest<BestResultItem> = BestResultItem.fetchRequest()

            let bestResults = try context.fetch(fetchRequest)

            // Tri en utilisant une fonction de comparaison personnalisée pour trouver le plus proche de PI
            let sortedResults = bestResults.sorted { (result1: BestResultItem, result2: BestResultItem) -> Bool in
                let piDifference1 = abs(result1.result - Double.pi)
                let piDifference2 = abs(result2.result - Double.pi)
                
                return piDifference1 < piDifference2
            }
        
            return sortedResults.first
        } catch {
            print("Error fetching best result: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getAllBestResults() -> [BestResultItem]? {
            do {
                let fetchRequest: NSFetchRequest<BestResultItem> = BestResultItem.fetchRequest()
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "points", ascending: true)]
                let bestResults = try context.fetch(fetchRequest)
                
                return bestResults
            } catch {
                print("Error fetching best results: \(error.localizedDescription)")
                return nil
            }
        
        }

    
    private func saveResultToCoreData(result: Double) {
            let fetchRequest: NSFetchRequest<BestResultItem> = BestResultItem.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "points == %d", Int32(self.totalPoints))

            do {
                let existingResults = try context.fetch(fetchRequest)

                if let existingResult = existingResults.first {
                    // Si le résultat existant est inférieur au nouveau résultat, mettez à jour
                    let piDifferenceExisting = abs(existingResult.result - Double.pi)
                    let piDifferenceNew = abs(result - Double.pi)
                    if piDifferenceNew < piDifferenceExisting {
                        existingResult.result = result
                    }
                } else {
                    // Si le résultat n'existe pas déjà, créez un nouvel enregistrement
                    let newItem = BestResultItem(context: context)
                    newItem.points = Int32(self.totalPoints)
                    newItem.result = result
                }

                try context.save()
                print("Result saved.")
            } catch {
                print("Error saving result to Core Data: \(error.localizedDescription)")
            }
        }
    
    func deleteAllBestResults() {
        do {
            let fetchRequest: NSFetchRequest<BestResultItem> = BestResultItem.fetchRequest()
            let allBestResults = try context.fetch(fetchRequest)

            for resultItem in allBestResults {
                context.delete(resultItem)
            }

            try context.save()
        } catch {
            print("Error deleting all best results: \(error.localizedDescription)")
        }
    }
}
