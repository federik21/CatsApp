//
//  CatViewModel.swift
//  Cats
//
//  Created by federico piccirilli on 19/11/2024.
//

import Foundation
import SwiftUI
import Combine

class CatViewModel: ObservableObject {
  @Published var cats: [CatItemModel] = []
  @Published var filteredBreeds: [CatItemModel] = []
  @Published var searchText: String = ""

  private var favourites = Set<String>()

  var isSearching : Bool {
    !searchText.isEmpty
  }

  private var catManager: CatManager

  private var cancellables = Set<AnyCancellable>()

  init(catManager: CatManager) {
    self.catManager = catManager
    addSubscribers()
  }

  func addSubscribers() {
    $searchText.sink {
      [weak self] text in
      self?.getFilteredBreeds(string: text)
    }.store(in: &cancellables)
  }

  @MainActor
  func getAllBreeds() async {
    favourites = await catManager.getFavourites()
    cats = await catManager.getAllBreeds()
  }

  func getFilteredBreeds(string text: String) {
    guard isSearching else {
      filteredBreeds = []
      return
    }
    filteredBreeds = cats.filter({ cat in
      return cat.name.lowercased().contains(text.lowercased())
    })
  }

  func isFavourite(_ breedId: String) -> Bool {
    favourites.contains(breedId)
  }

  @MainActor
  func setFavorite(_ breedId: String) async {
    await catManager.setFavourite(breedId, !isFavourite(breedId))
    favourites = await catManager.getFavourites()
  }
}
