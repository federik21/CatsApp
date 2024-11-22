//
//  Uitls.swift
//  Cats
//
//  Created by federico piccirilli on 21/11/2024.
//

import SwiftUI

extension View {
  // Display the search bar only if if a condition is met.
  @ViewBuilder
  func searchable(_ condition: Bool, text: Binding<String>,placement: SearchFieldPlacement = .automatic,prompt: String) -> some View {
    if condition {
      self.searchable(
        text: text,
        placement: placement,
        prompt: prompt
      )
    } else {
      self
    }
  }
}
