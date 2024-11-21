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

  enum ViewFilter {
    case name, favs
  }

  @Published var cats: [CatItemViewModel] = []
  @Published var filteredBreeds: [CatItemViewModel] = []

  @Published var searchText: String = ""

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
    cats = await catManager.getAllBreeds().map {
      CatItemViewModel(name: $0.name!, picUrl: "nil",
                       isFav: false)
    }
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

  func getCatImageUrl(_ imageId: String?) async -> URL? {
    guard let image = imageId else { return nil }
    return await catManager.getCatImageUrl(image)
  }
}

struct CatItemViewModel: Hashable {
  var name: String
  var picUrl: String
  var isFav: Bool
}
