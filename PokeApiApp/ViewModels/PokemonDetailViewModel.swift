//
//  PokemonDetailViewModel.swift
//  PokeApiApp
//
//  Created by Juanjo on 16/07/2026.
//
import Foundation

@Observable
@MainActor
final class PokemonDetailViewModel {
    var state: LoadState<PokemonDetail> = .loading
    private let service = Service()
    
    func loadDetail(_ id: Int) async {
        state = .loading
        do {
            let pokemonDetail = try await service.fetchPokemonDetail(id)
            state = .loaded(pokemonDetail)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
