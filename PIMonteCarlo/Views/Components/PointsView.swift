//
//  PointsView.swift
//  PIMonteCarlo
//
//  Created by Rémy Castro on 18/12/2023.
//

import SwiftUI

struct PointsView: View {
    let points: [MonteCarloPoint]

    var body: some View {
            GeometryReader { geometry in
                Canvas { context, _ in
                    for point in points {
                        context.fill(Path(CGRect(x: point.x * geometry.size.width, y: (1 - point.y) * geometry.size.height, width: 1, height: 1)), with: point.insideCircle ? .color(.blue) : .color(.red))
                    }
                }
            }
        }
}

