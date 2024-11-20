//
//  CatViewModel.swift
//  Cats
//
//  Created by federico piccirilli on 19/11/2024.
//

import Foundation
import SwiftUI

class CatViewModel: ObservableObject {

  enum ViewFilter {
    case name, favs
  }

  @Published var cats: [CatItemViewModel] = []
  var mode: CatsViewFilter = .name

  private var catManager: CatManager

  init(catManager: CatManager) {
    self.catManager = catManager
  }
  
  func getAllBreeds() async {
    cats = await catManager.getAllBreeds().map {
      CatItemViewModel( name: $0.name!,
                       picUrl: "https://api.thecatapi.com/v1/images/0XYvRd7oD",
                       isFav: false)
    }
  }
}

struct CatItemViewModel: Hashable {
  var name: String
  var picUrl: String
  var isFav: Bool
}
