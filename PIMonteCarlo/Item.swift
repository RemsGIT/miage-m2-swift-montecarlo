//
//  Item.swift
//  PIMonteCarlo
//
//  Created by Rémy Castro on 17/12/2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
