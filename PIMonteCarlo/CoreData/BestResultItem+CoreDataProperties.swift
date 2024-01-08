//
//  BestResultItem+CoreDataProperties.swift
//  PIMonteCarlo
//
//  Created by Rémy Castro on 19/12/2023.
//


import Foundation
import CoreData

extension BestResultItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BestResultItem> {
        return NSFetchRequest<BestResultItem>(entityName: "BestResultItem")
    }

    @NSManaged public var points: Int32
    @NSManaged public var result: Double

}

extension BestResultItem : Identifiable {

}
