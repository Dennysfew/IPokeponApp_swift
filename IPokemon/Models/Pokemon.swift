//
//  Pokemon.swift
//  IPokemon
//
//  Created by Denys on 15.04.2022.
//

import Foundation

struct Pokemon: Codable {
    var name: String
    var url: String
}

struct Pokemons: Codable{
    var results: [Pokemon]
}








