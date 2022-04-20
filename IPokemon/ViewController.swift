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
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }

        
        
    }
    func parse (json: Data){
        let decoder = JSONDecoder()

        if let jsonPokemons = try? decoder.decode(Pokemons.self, from: json){
            pokemons = jsonPokemons.results

            tableView.reloadData()
        }
    }
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
       let pokemon = pokemons[indexPath.row]
        cell.textLabel?.text = pokemon.name
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.name = pokemons[indexPath.row].name
        vc.pokemon = pokemons[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        

    }
    
    
    
}

