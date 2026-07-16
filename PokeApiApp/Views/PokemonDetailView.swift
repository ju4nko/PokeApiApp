//
//  PokemonDetailView.swift
//  PokeApiApp
//
//  Created by Juanjo on 16/07/2026.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    @State private var viewModel = PokemonDetailViewModel()
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView("Cargando")
            case .loaded(let pokemonDetail):
                ScrollView {
                    VStack(spacing: 16) {
                        AsyncImage(url: pokemon.spriteURL) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 200, height: 200)
                        HStack {
                            ForEach(pokemonDetail.types, id: \.type.name) { entry in
                                Text(entry.type.name.capitalized)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(.blue.opacity(0.2), in: .capsule)
                            }
                        }
                        HStack(spacing: 40) {
                            VStack {
                                Text("Altura").font(.caption).foregroundStyle(.secondary)
                                Text("\(pokemonDetail.heightInMeters.formatted()) m")
                            }
                            VStack {
                                Text("Peso").font(.caption).foregroundStyle(.secondary)
                                Text("\(pokemonDetail.weightInKilos.formatted()) kg")
                            }
                        }
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(pokemonDetail.stats, id: \.stat.name) { entry in
                                HStack {
                                    Text(entry.stat.name.capitalized)
                                        .frame(width: 130, alignment: .leading)
                                    Text("\(entry.baseStat)")
                                        .frame(width: 40)
                                    ProgressView(value: Double(entry.baseStat), total: 255)
                                }
                                .font(.caption)
                            }
                        }
                        
                    }
                    .padding()
                }
            case .error(let message):
                ContentUnavailableView {
                    Label("No se pudo cargar", systemImage: "wifi.exclamationmark")
                } description: {
                    Text(message)
                } actions: {
                    Button("Reintentar") {
                        Task { await viewModel.loadDetail(pokemon.id)}
                    }
                }
            }
        }
        .navigationTitle(pokemon.name.capitalized)
        .task {
            await viewModel.loadDetail(pokemon.id)
        }
        
    }
}

#Preview {
    PokemonDetailView(pokemon: Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1"))
}
