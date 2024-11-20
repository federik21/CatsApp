//
//  ContentView.swift
//  Cats
//
//  Created by federico piccirilli on 19/11/2024.
//

import SwiftUI
import CoreData
import Combine

struct ContentView: View {
  @StateObject var viewModel: CatViewModel
  @State private var searchText: String = ""
  @State private var selectedTab: Int = 0

  var body: some View {
    NavigationView {
      VStack(spacing: 0) {

        // Image Grid
        ScrollView {
          LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
            ForEach(viewModel.cats, id: \.self) { item in
              VStack {
                AsyncImage(url: URL(string: item.picUrl))
                  .aspectRatio(contentMode: .fill)
                Text(item.name)
              }

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
    }.searchable(text: $searchText)
    .task {
      await viewModel.getAllBreeds()
    }
  }
}

// Preview
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(viewModel: CatViewModel(catManager: CatManager(networkClient: MockNetworkService())))
  }
}
