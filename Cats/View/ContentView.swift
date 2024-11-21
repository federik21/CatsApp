//
//  ContentView.swift
//  Cats
//
//  Created by federico piccirilli on 19/11/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @StateObject var viewModel: CatViewModel
  @State private var selectedTab: Int = 0

  var body: some View {
    NavigationView {
      VStack {
        ScrollView {
          LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
            ForEach((getBreedsToShow()), id: \.self) { item in
              CatItemView(item: item)
            }
          }
          .padding()
        }

        // Tab Bar
        HStack {
          Spacer()

          TabBarButton(icon: "magnifyingglass", title: "Search", isSelected: selectedTab == 0)
            .onTapGesture {
              selectedTab = 0
              
            }

          Spacer()

          TabBarButton(icon: "star.fill", title: "Favourites", isSelected: selectedTab == 1)
            .onTapGesture {
              selectedTab = 1
            }
          Spacer()

        }
        .padding()
        .background(Color(.systemGray5))
      }
      .edgesIgnoringSafeArea(.bottom)
    }
    .searchable((selectedTab == 0), text: $viewModel.searchText, prompt: "Search breed...")
    .task {
      await viewModel.getAllBreeds()
    }
  }

  fileprivate func getBreedsToShow() -> [CatItemViewModel] {
    guard selectedTab == 0 else {
      return viewModel.favouriteFilter
    }
    return !viewModel.isSearching ? viewModel.cats : viewModel.filteredBreeds
  }
}

// Preview
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(viewModel: CatViewModel(catManager: CatManager(networkClient: MockNetworkService(), databaseClient: CoredataService())))
  }
}
