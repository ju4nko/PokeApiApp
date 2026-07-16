//
//  LoadState.swift
//  PokeApiApp
//
//  Created by Juanjo on 16/07/2026.
//

enum LoadState<Value> {
    case loading
    case loaded(Value)
    case error(String)
}
