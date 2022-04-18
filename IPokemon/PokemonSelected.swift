//
//  PokemonSelected.swift
//  IPokemon
//
//  Created by Denys on 15.04.2022.
//

import Foundation

struct PokemonSelected: Codable {
    
    var sprites: PokemonSprites
    var weight: Int
}

struct PokemonSprites: Codable{
    var front_default: String?
}

class PokeSelectedApi{
    func getData(url: String, completion: @escaping(PokemonSprites) ->()){
        guard let url = URL(string: url) else {
            return
        }
        URLSession.shared.dataTask(with: url){
            (data, response, error) in
            guard let data = data else { return }
            
            let pokemonSprite = try! JSONDecoder().decode(PokemonSelected.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemonSprite.sprites)
            }
        }.resume()
    
    }
}
