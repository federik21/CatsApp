//
//  DetailView.swift
//  Cats
//
//  Created by federico piccirilli on 21/11/2024.
//

import SwiftUI

struct DetailView: View {
// Referencing the CatViewModel set as Env by the parent.
  @EnvironmentObject var viewModel: CatViewModel

// Using a state just to keep the state status inside the child.
// Data is syncronized on appear and after tapping the button.
  @State var favourite: Bool = false
  var cat: CatItemModel
  
  var body: some View {
    VStack {
      ScrollView {
        AsyncImage(url: URL(string: cat.picUrl)) { imagePhase in
          switch imagePhase {
          case .success(let image):
            image
              .resizable()
              .scaledToFit()
          case .failure:
            Image(systemName: "photo") // Placeholder for failure
              .resizable()
              .scaledToFit()
          default:
            ProgressView() // Placeholder while loading
          }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)

        Text(cat.name)
          .font(.headline)
        Text(cat.origin)
          .font(.caption)
        Text(cat.temperament)
          .font(.caption)
          .padding()
        Text(cat.description)
          .font(.footnote)
        Button(action: {
          Task {
            await viewModel.setFavorite(cat.id)
            favourite = viewModel.isFavourite(cat.id)
            // Manually notify observers about the change
            // Otherwise, returning to the parent list view (if Favourite) will still dislay this item without the Fav status.
            viewModel.objectWillChange.send()
          }
        }) {
          Image(systemName: favourite ? "star.fill" : "star")
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(favourite ? .yellow : .gray)
            .padding()
            .background(Circle().fill(Color.white))
            .shadow(radius: 3)
        }
      }
    }.padding()
    .navigationTitle(cat.name)
    .navigationBarTitleDisplayMode(.inline)
    .onAppear {
      favourite = viewModel.isFavourite(cat.id)
    }
  }
}
