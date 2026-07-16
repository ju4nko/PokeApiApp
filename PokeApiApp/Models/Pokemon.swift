//
//  Pokemon.swift
//  PokeApiApp
//
//  Created by Juanjo on 16/07/2026.
//
import Foundation

struct Pokemon: Decodable, Identifiable, Hashable{
    let name: String
    let url: String
    var id: Int {
        Int(url.split(separator: "/").last ?? "") ?? 0
    }
    var spriteURL: URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")
    }
}

struct Pokemons: Decodable {
    let results: [Pokemon]
}
