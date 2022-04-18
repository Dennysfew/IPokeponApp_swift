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

class PokeApi{
    func getData(completion: @escaping([Pokemon]) ->()){
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=135") else {
            return
        }
        URLSession.shared.dataTask(with: url){
            (data, response, error) in
            guard let data = data else { return }
            
            let pokemonList = try! JSONDecoder().decode(Pokemons.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemonList.results)
            }
        }.resume()
    
    }
}

