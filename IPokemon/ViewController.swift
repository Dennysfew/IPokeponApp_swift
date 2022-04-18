//
//  ViewController.swift
//  IPokemon
//
//  Created by Denys on 13.04.2022.
//

import UIKit


class ViewController: UITableViewController {

   
    var pokemons = [Pokemon]()
    
   //var pokemonSprites = [PokemonSelected]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "iPokemon"
     
     let urlString = "https://pokeapi.co/api/v2/pokemon?limit=135"
//        let urlStringBulbasur = "https://pokeapi.co/api/v2/pokemon/bulbasaur"
//
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
//        if let url = URL(string: urlStringBulbasur) {
//            if let data = try? Data(contentsOf: url) {
//                parseBulbasur(json: data)
//            }
//        }
        
        
//        PokeApi().getData() { pokemon in
//            self.pokemon = pokemon
//
////            for pokemon in pokemon {
////                print(pokemon.name)
////                self.pokemon.append(pokemon)
////            }
//        }
        
        
        
       PokeSelectedApi().getData(url: "https://pokeapi.co/api/v2/pokemon/1") { url in print(url)}
//
//
//
        
        
    }
    func parse (json: Data){
        let decoder = JSONDecoder()

        if let jsonPokemons = try? decoder.decode(Pokemons.self, from: json){
            pokemons = jsonPokemons.results

            tableView.reloadData()
        }
    }
//    func parseBulbasur (json: Data){
//        let decoder = JSONDecoder()
//
//        if let jsonPokemons = try? decoder.decode(PokemonSprites.self, from: json){
//            pokemonSprites = jsonPokemons.sprites
//
//            tableView.reloadData()
//        }
//    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
       let pokemon = pokemons[indexPath.row]
//        let spritePok = pokemonSprites[indexPath.row]
//        print(spritePok)
        
        
        cell.textLabel?.text = pokemon.name

   // cell.textLabel?.text = pokemon.name
//        cell.detailTextLabel?.text = "Subtitle goes here"
//
      //  if let url = URL(string: url)
     
        return cell
    }
}

