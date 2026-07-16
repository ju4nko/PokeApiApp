//
//  PokemonDetail.swift
//  PokeApiApp
//
//  Created by Juanjo on 16/07/2026.
//
import Foundation

struct PokemonDetail: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [TypeEntry]
    let stats: [StatEntry]
    var heightInMeters: Double {
        Double(height) / 10
    }
    var weightInKilos: Double {
        Double(weight) / 10
    }
    
    struct TypeEntry: Decodable {
        let type: NamedResource
    }
    struct StatEntry: Decodable {
        let baseStat: Int
        let stat: NamedResource
    }
    struct NamedResource: Decodable {
        let name: String
    }
}
