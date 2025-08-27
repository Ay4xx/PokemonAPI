//
//  ContentView.swift
//  Activity6
//
//  Created by Alumno on 26/08/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var pokeVM = PokemonListViewModel()


    var body: some View {
        NavigationStack {
            Group {
                if pokeVM.arrPokeDetail.isEmpty {
                    // Indicador mientras carga
                    ProgressView("Cargando Pokémon…")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(pokeVM.arrPokeDetail) { pokemon in
                        NavigationLink {
                            DetailView(pokemon: pokemon)
                        } label: {
                            PokemonRowView(pokemon: pokemon)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Pokedex")
        }
    }
}

#Preview {
    ContentView()
}
