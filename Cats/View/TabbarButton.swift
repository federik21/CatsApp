//
//  TabbarButton.swift
//  Cats
//
//  Created by federico piccirilli on 19/11/2024.
//

import SwiftUI

struct TabBarButton: View {
  let icon: String
  let title: String
  let isSelected: Bool

  var body: some View {
    VStack {
      Image(systemName: icon)
        .font(.system(size: 24))
        .foregroundColor(isSelected ? .blue : .gray)
      Text(title)
        .font(.caption)
        .foregroundColor(isSelected ? .blue : .gray)
    }
  }
}
