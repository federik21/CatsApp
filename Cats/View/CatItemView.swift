//
//  CatItemView.swift
//  Cats
//
//  Created by federico piccirilli on 21/11/2024.
//

import SwiftUI

struct CatItemView: View {
  @EnvironmentObject var viewModel: CatViewModel
  @State var favourite: Bool = false
  var cat: CatItemModel

  var body: some View {
    VStack {
      ZStack(alignment: .topTrailing) {
        AsyncImage(url: URL(string: cat.picUrl)) { imagePhase in
          switch imagePhase {
          case .success(let image):
            image
              .resizable()
              .scaledToFit()
          case .failure:
            Image(systemName: "photo")
              .resizable()
              .scaledToFit()
          default:
            ProgressView()
          }
        }
        Button(action: {
          Task{
            await viewModel.setFavorite(cat.id)
            favourite = viewModel.isFavourite(cat.id)
          }
        }) {
          // Star overlay
          Image(systemName: favourite ? "star.fill" : "star")
            .foregroundColor(favourite ? .yellow : .black)
            .padding(8)
            .background(Circle().fill(Color.white))
            .shadow(radius: 3)
        }
      }
      Text(cat.name)
    }.frame(width: 150, height: 150) // Ensure consistent sizing
      .onAppear {
        favourite = viewModel.isFavourite(cat.id)
      }
  }
}
