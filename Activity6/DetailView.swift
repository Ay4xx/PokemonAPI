//
//  DetailView.swift
//  Activity6
//
//  Created by Alumno on 26/08/25.
//

import SwiftUI

struct DetailView: View {
    let pokemon: Pokemon

    var body: some View {
        VStack(spacing: 12) {
            Text(pokemon.name.capitalized)
                .font(.title2)
                .bold()

            if let urlString = pokemon.sprites.front_default,
               let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 100)
                }
            } else {
                Color.gray
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            Text("Base EXP: \(pokemon.base_experience)")
            Text(String(format: "Height: %.1f m", pokemon.height))
        }
        .padding()
    }
}

#Preview {
    DetailView(
        pokemon: Pokemon(
            id: 1,
            name: "bulbasaur",
            height: 0.7,                    // Double
            base_experience: 64,            // Int
            species: .init(                 // Pokemon.Species
                name: "bulbasaur",
                url: "https://pokeapi.co/api/v2/pokemon-species/1/"
            ),
            sprites: .init(                 // Pokemon.Sprites
                front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
            )
        )
    )
}
