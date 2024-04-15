//
//  Model.swift
//  Test_Carso
//
//  Created by Alejandro Guerra on 10/04/24.
//

import Foundation

struct Response: Codable {
  var results: [Pokemon]
  var count: Int
  var previous: String?
  var next: String?
  var pokemons: [PokemonDetail]?
}

struct Pokemon: Codable {
  var name: String
  var url: String
}

struct PokemonDetail: Codable {
  
  //var abilities: [Ability]?
  var base_experience: Int?
  //var cries: [Form]?
  //var forms: Int
  var id: Int
  var name: String
  
  // Types
  struct type: Codable {
    var name: String
    var url: String
  }
  struct Types: Codable {
    var slot: Int
    var type: type
  }
  
  var types: [Types]
  
  // Sprites
  struct Sprites: Codable {
    var front_default: String?
    var front_shiny: String?
  }
  var sprites: Sprites
  
  // Stats
  struct Stat: Codable {
    var name: String
    var url: String
  }
  struct Stats: Codable {
    var base_stat: Int
    var effort: Int
    var stat: Stat
  }
  
  var stats: [Stats]
}

struct Ability: Codable {
  var name: String
  var url: String
}

struct Form: Codable {
  var name: String
  var url: String
}
