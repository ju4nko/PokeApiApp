//
//  PokedexViewModel.swift
//  PokeApiApp
//
//  Created by Juanjo on 16/07/2026.
//
import Foundation


@Observable
@MainActor
final class PokedexViewModel {
    var state: LoadState<[Pokemon]> = .loading
    private let service = Service()
    
    func loadPokemon() async {
        state = .loading
        do {
            let pokemons = try await service.fetchPokemon()
            state = .loaded(pokemons.results)
        } catch {
            state = .error(error.localizedDescription)
        }
    }

}
