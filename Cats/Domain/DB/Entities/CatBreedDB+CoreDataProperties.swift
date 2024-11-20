//
//  CatBreedDB+CoreDataProperties.swift
//  Cats
//
//  Created by federico piccirilli on 20/11/2024.
//
//

import Foundation
import CoreData


extension CatBreedDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CatBreedDB> {
        return NSFetchRequest<CatBreedDB>(entityName: "CatBreedDB")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var lifeSpan: String?
    @NSManaged public var referenceImageId: String?
    @NSManaged public var origin: String?
    @NSManaged public var temperament: String?
    @NSManaged public var favourite: Bool

}

extension CatBreedDB : Identifiable {

}
