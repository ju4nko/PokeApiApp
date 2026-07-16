//
//  PokemonRowView.swift
//  PokeApiApp
//
//  Created by Juanjo on 16/07/2026.
//

import SwiftUI

struct PokemonRowView: View {
    let pokemon: Pokemon
    
    var body: some View {
        HStack {
            AsyncImage(url: pokemon.spriteURL) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)
            Text(pokemon.name.capitalized)
            Spacer()
            Text("#\(pokemon.id)")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    PokemonRowView(pokemon: Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"))
}
