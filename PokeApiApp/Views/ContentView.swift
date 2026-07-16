//
//  ContentView.swift
//  PokeApiApp
//
//  Created by Juanjo on 16/07/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = PokedexViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .loading:
                    ProgressView("Cargando...")
                case .loaded(let pokemons):
                    List(filtered(pokemons)) { pokemon in
                        NavigationLink(value: pokemon) {
                            PokemonRowView(pokemon: pokemon)
                        }
                    }
                    .searchable(text: $searchText, prompt: "Buscar pokemon")
                case .error(let message):
                    ContentUnavailableView {
                        Label("No se pudo cargar", systemImage: "wifi.exclamationmark")
                    } description: {
                        Text(message)
                    } actions: {
                        Button("Reintentar") {
                            Task { await viewModel.loadPokemon() }
                        }
                    }
                }
                
            }
            .navigationDestination(for: Pokemon.self) { pokemon in
                PokemonDetailView(pokemon: pokemon)
            }
            .navigationTitle("Pokédex")
            .task {
                 await viewModel.loadPokemon()
            }
        }
        
    }
    
    private func filtered(_ pokemons: [Pokemon]) -> [Pokemon] {
        guard !searchText.isEmpty else { return pokemons }
        return pokemons.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
}

#Preview {
    ContentView()
}
