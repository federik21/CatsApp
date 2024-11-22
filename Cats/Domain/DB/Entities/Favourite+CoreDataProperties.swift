//
//  Favourite+CoreDataProperties.swift
//  Cats
//
//  Created by federico piccirilli on 21/11/2024.
//
//

import Foundation
import CoreData


extension Favourite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourite> {
        return NSFetchRequest<Favourite>(entityName: "Favourite")
    }

    @NSManaged public var cat: CatBreedDB?

}

extension Favourite : Identifiable {

}
