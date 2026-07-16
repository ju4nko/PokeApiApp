//
//  Service.swift
//  PokeApiApp
//
//  Created by Juanjo on 16/07/2026.
//
import Foundation

struct Service {
    let pokemonURL = "https://pokeapi.co/api/v2/pokemon/?limit=151"
    
    func fetchPokemon() async throws -> Pokemons {
        try await fetch(from: pokemonURL)
    }
    func fetchPokemonDetail(_ id: Int) async throws -> PokemonDetail {
        try await fetch(from: "https://pokeapi.co/api/v2/pokemon/\(id)")
    }
    
    func fetch<T: Decodable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else { throw ServiceError.invalidURL }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw ServiceError.badResponse(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
        }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw ServiceError.decodingFailed
        }
    }
}

enum ServiceError: Error {
    case invalidURL
    case badResponse(statusCode: Int)
    case decodingFailed
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            "La URL no es válida"
        case .badResponse(let statusCode):
            "El servidor respondió con código \(statusCode)"
        case .decodingFailed:
            "No se pudo decodificar la respuesta"
        }
    }
}
