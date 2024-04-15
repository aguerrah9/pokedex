//
//  ContentView.swift
//  Test_Carso
//
//  Created by Alejandro Guerra on 10/04/24.
//

import SwiftUI

struct ContentView: View {
  @State private var results = [PokemonDetail]()
  @State private var searchText = ""
  @State private var prevPageUrl: String?
  @State private var nextPageUrl: String?
  @State private var loading: Bool = false
  @State private var currentPage = 0
  @State private var pages:Int = 0
  @State private var totalPokemons = 0
  
  var body: some View {
    
    NavigationStack {
      ZStack {
        List (searchResults, id: \.id) { item in
          LazyVStack {
            NavigationLink {
              PokemonDetalle( pokemon: item, searchText: $searchText )
            } label: {
              HStack{
                
                pokemonImage(url: item.sprites.front_default ?? "")
                
                Text("#\(item.id) \(item.name.capitalized)")
                  .font(.headline)
              }
            }
          }
          .onAppear {
            print(item.name)
            if let lastPoke = results.last {
              if item.name == lastPoke.name && nextPageUrl != nil {
                Task {
                  if loading == true {
                    return
                  }
                  loading = true
                  await loadList(url: nextPageUrl ?? "")
                }
              }
            }
          }
        }
        .navigationTitle("Pokedex")
        .toolbar {
          ToolbarItem (placement: .bottomBar) {
            Text("\(results.count) of \(totalPokemons) pokemons")
          }
        }
        
        if loading {
          ProgressView().scaleEffect(4)
        }
      }
      
    }
    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
    
    .task {
      loading = true
      await loadList(url: "https://pokeapi.co/api/v2/pokemon")
    }.padding()
    
  }
  
  var searchResults: [PokemonDetail] {
    if searchText.isEmpty {
      return results
    } else if Int(searchText) != nil {
      return results.filter {
        $0.id == Int(searchText)
      }
    } else {
      return results.filter { $0.name.contains(searchText.lowercased())
        || $0.types.map{$0.type.name}.contains(searchText.lowercased())
      }
    }
  }
  
  func loadList(url: String) async {
    let response = await dataManager().loadData( urlString: url)
    totalPokemons = response?.count ?? 0
    results = results + (response?.pokemons ?? [])
    let calculatePages: Float = Float(response?.count ?? 0) / 20
    //currentPage = 1
    pages = Int(ceil(calculatePages))
    //print("pages",pages)
    prevPageUrl = response?.previous ?? nil
    nextPageUrl = response?.next
    loading = false
    
  }
  
}

#Preview {
    ContentView()
}
