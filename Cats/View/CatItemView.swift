//
//  CatItemView.swift
//  Cats
//
//  Created by federico piccirilli on 21/11/2024.
//

import SwiftUI

struct CatItemView: View {
  var item: CatItemViewModel
  var body: some View {
    VStack {
      ZStack(alignment: .topTrailing) {
        AsyncImage(url: URL(string: item.picUrl)) { imagePhase in
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
        // Star overlay
        Image(systemName: item.isFav ? "star.fill" : "star")
          .foregroundColor(item.isFav ? .yellow : .black)
          .padding(8)
          .background(Circle().fill(Color.white))
          .shadow(radius: 3)
      }
      Text(item.name)
    }.frame(width: 150, height: 150) // Ensure consistent sizing

  }

  init(item: CatItemViewModel){
    self.item = item
  }
}
