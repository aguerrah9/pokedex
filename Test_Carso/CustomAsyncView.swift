//
//  CustomAsyncView.swift
//  Test_Carso
//
//  Created by Alejandro Guerra on 14/04/24.
//

import SwiftUI

func pokemonImage(url: String) -> some View {
  return AsyncImage(url: URL(string: url)) { phase in
    let anchor:CGFloat = 64
    if let image = phase.image {
      image
        .frame( width: anchor, height: anchor )
    } else if phase.error != nil {
      Image(systemName: "questionmark.square.dashed")
        .frame( width: anchor, height: anchor )
    } else {
      ProgressView()
        .frame( width: anchor, height: anchor )
    }
  }
  
}
