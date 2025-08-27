//
//  RowView.swift
//  Activity6
//
//  Created by Alumno on 26/08/25.
//

import SwiftUI

struct PokemonRowView: View {
    let pokemon: Pokemon

    var body: some View {
        HStack(spacing: 12) {
            if let urlString = pokemon.sprites.front_default,
               let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 72, height: 72)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } placeholder: {
                    ProgressView()
                        .frame(width: 72, height: 72)
                }
            } else {
                Color.gray
                    .frame(width: 72, height: 72)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(pokemon.name.capitalized)
                    .font(.headline)
                Text("Base EXP: \(pokemon.base_experience)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    PokemonRowView(
        pokemon: Pokemon(
            id: 1,
            name: "bulbasaur",
            height: 0.7,
            base_experience: 64,
            species: .init(
                name: "bulbasaur",
                url: "https://pokeapi.co/api/v2/pokemon-species/1/"
            ),
            sprites: .init(
                front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
            )
        )
    )
}
