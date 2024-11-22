//
//  DatabaseService.swift
//  Cats
//
//  Created by federico piccirilli on 20/11/2024.
//

import Foundation
import CoreData

protocol DatabaseService {
  func cacheData(_ catBreed: CatBreed)
  func getCachedCatBreeds() -> [CatBreed]
  func getFavouriteCatBreeds() -> [String]
  func toggleFavorite(_ breedId: String, _ isFavourite: Bool)
}

class CoredataService: DatabaseService {
  let dataBaseContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext

  func cacheData(_ catBreed: CatBreed) {
    guard let catId = catBreed.id else { return }
    let catEntity = getCatWithId(catId) ?? CatBreedDB(context: dataBaseContext)
    catEntity.id = catBreed.id
    catEntity.name = catBreed.name
    catEntity.temperament = catBreed.temperament
    catEntity.origin = catBreed.origin
    catEntity.descriptionText = catBreed.description
    catEntity.lifeSpan = catBreed.lifeSpan
    catEntity.referenceImageId = catBreed.referenceImageID
    saveContext(context: dataBaseContext)
  }

  private func getCatWithId(_ id: String) -> CatBreedDB? {
    let fetchCat: NSFetchRequest<CatBreedDB> = CatBreedDB.fetchRequest()
    fetchCat.predicate = NSPredicate(format: "id = %@", id)
    let results = try? dataBaseContext.fetch(fetchCat)
    return results?.first
  }

  func getCachedCatBreeds() -> [CatBreed] {
    let fetchRequest: NSFetchRequest<CatBreedDB> = CatBreedDB.fetchRequest()
    do {
      let cats = try dataBaseContext.fetch(fetchRequest)
      var results = [CatBreed]()
      for entity in cats {
        results.append(CatBreed(from: entity))
      }
      return results
    } catch {
      print("Failed to fetch CatBreeds: \(error)")
      return []
    }
  }

  func getFavouriteCatBreeds() -> [String] {
    let fetchRequest: NSFetchRequest<Favourite> = Favourite.fetchRequest()
    fetchRequest.relationshipKeyPathsForPrefetching = ["cat"]
    do {
      let fav = try dataBaseContext.fetch(fetchRequest)
      return fav.map{$0.cat!.id!}
    } catch {
      print("Failed to fetch cats: \(error)")
      return []
    }
  }

  func toggleFavorite(_ breedId: String, _ isFavourite: Bool) {
    guard let catEntity = getCatWithId(breedId) else { return }
    if isFavourite {
      let favourite = Favourite(context: dataBaseContext)
      favourite.cat = catEntity
    } else if let currentFavourite = catEntity.favourite {
      dataBaseContext.delete(currentFavourite)
    }
    saveContext(context: dataBaseContext)
  }

  private func saveContext(context: NSManagedObjectContext) {
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }
}
extension CatBreed {
  init(from catEntity: CatBreedDB) {
    self.id = catEntity.id
    self.name = catEntity.name
    self.temperament = catEntity.temperament
    self.origin = catEntity.origin
    self.description = catEntity.descriptionText
    self.lifeSpan = catEntity.lifeSpan
    self.referenceImageID = catEntity.referenceImageId
  }
}
