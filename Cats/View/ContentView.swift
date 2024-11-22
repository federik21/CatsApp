//
//  ContentView.swift
//  Cats
//
//  Created by federico piccirilli on 19/11/2024.
//

import SwiftUI
import CoreData

// Main view of the app
struct ContentView: View {
  // Observable ViewModel defined here and used with Environmental Object in Childrens
  @StateObject var viewModel: CatViewModel
  @State private var selectedTab: Int = 0

  var body: some View {
    NavigationStack {
      VStack {
        ScrollView {
          LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
            ForEach((getBreedsToShow()), id: \.self) { item in
              NavigationLink(destination: DetailView(cat: item)) {
                CatItemView(cat: item,
                            showLifeSpan: selectedTab == 1 && viewModel.isFavourite(item.id))
              }
            }
          }
          .padding()
        }.navigationTitle("Cats")

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
    // Set ViewModel available in subViews
    .environmentObject(viewModel)
  }

  fileprivate func getBreedsToShow() -> [CatItemModel] {
    guard selectedTab == 0 else {
      return viewModel.cats.filter{viewModel.isFavourite($0.id)}
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
