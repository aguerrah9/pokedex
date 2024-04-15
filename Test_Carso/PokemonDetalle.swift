//
//  PokemonDetalle.swift
//  Test_Carso
//
//  Created by Alejandro Guerra on 11/04/24.
//

import SwiftUI

struct PokemonDetalle: View {
  var pokemon: PokemonDetail?
  @Binding var searchText: String
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    VStack {
      Text("")
        .navigationTitle( "\(pokemon?.name ?? "Detalle") \n# \(pokemon?.id ?? 0)").lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
      
      HStack {
        
        pokemonImage(url: pokemon?.sprites.front_default ?? "").padding().shadow(radius: 8, x: 5, y:5)
        
        pokemonImage(url: pokemon?.sprites.front_shiny ?? "").padding().shadow(radius: 8, x: 5, y:5)
        
      }
      
      Text("Tipos").font(.headline)
      HStack{
        //Text(pokemon?.types.map{$0.type.name}.joined(separator:", ") ?? "").padding(.bottom)
        ForEach(pokemon?.types ?? [], id: \.slot) { type in
          linkColor(typename: type.type.name)
        }
      }

      Text("Stats").font(.headline)
      HStack{
        Text(pokemon?.stats.map{
          "\($0.stat.name): \(String($0.base_stat))"
        }.joined(separator:"\n") ?? "")
      }
    }
    
  }
  
  
  func linkColor(typename: String) -> some View {
    var colorType = 0x0
    switch typename {
    case "normal":
      colorType = 0xA8A77A
    case "fighting":
      colorType = 0xC22E28
    case "flying":
      colorType = 0xA98FF3
    case "poison":
      colorType = 0xA33EA1
    case "ground":
      colorType = 0xE2BF65
    case "rock":
      colorType = 0xB6A136
    case "bug":
      colorType = 0xA6B91A
    case "ghost":
      colorType = 0x735797
    case "steel":
      colorType = 0xB7B7CE
    case "fire":
      colorType = 0xEE8130
    case "water":
      colorType = 0x6390F0
    case "grass":
      colorType = 0x7AC74C
    case "electric":
      colorType = 0xF7D02C
    case "psychic":
      colorType = 0xF95587
    case "ice":
      colorType = 0x96D9D6
    case "dragon":
      colorType = 0x6F35FC
    case "dark":
      colorType = 0x705746
    case "fairy":
      colorType = 0xD685AD
    case "unknown":
      colorType = 0x0
    case "shadow":
      colorType = 0x0
    default:
      colorType = 0x0
    }
    return Button(action: {
      self.searchText = typename
      self.dismiss()
    }) {
      Text(typename).foregroundStyle( Color(hex: colorType )).padding(.bottom)
    }
  }
  
}
/*
#Preview {
  PokemonDetalle(pokemon: nil, selectedItem: "")
}*/

extension Color {
    init(hex: Int, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
