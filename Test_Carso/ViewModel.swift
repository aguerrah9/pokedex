//
//  ViewModel.swift
//  Test_Carso
//
//  Created by Alejandro Guerra on 10/04/24.
//

import Foundation

struct dataManager {
  func loadData(urlString: String) async -> Response? {
    var response: Response
    guard let url = URL(string: urlString) else {
      print("URL inválida")
      return nil
    }
    var pokemons = [PokemonDetail]()
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      
      guard let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) else {
        print("Couldnt decode")
        return nil
      }
      let results = decodedResponse.results
      response = decodedResponse
      
      for pokemon in results {
        //print(pokemon.url)
        if let poke = await PokemonAPI().loadDetail(urlString: pokemon.url) {
          pokemons.append(poke)
        }
      }
      
      response.pokemons = pokemons
      
    } catch {
      print("información inválida")
      return nil
    }
    return response
  }
}

struct PokemonAPI {
  func loadDetail(urlString: String) async -> PokemonDetail? {
    
    guard let url = URL(string: urlString) else {
      print("URL inválida")
      return nil
    }
    
    var pokemonDetail: PokemonDetail? = nil
    
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      
      guard let decodedResponse = try? JSONDecoder().decode(PokemonDetail.self, from: data) else {
        print("Couldnt decode")
        return nil
      }
      pokemonDetail = decodedResponse
      
    } catch {
      print("información inválida")
      return nil
    }
    
    return pokemonDetail
  }
}

