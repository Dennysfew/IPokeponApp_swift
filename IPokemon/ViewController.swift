//
//  ViewController.swift
//  IPokemon
//
//  Created by Denys on 13.04.2022.
//

import UIKit
import Kingfisher

class ViewController: UITableViewController {
    var pokemons = [Pokemon]()
    let apiService: APIService = APIService()
    
    var pokemonSelected = [PokemonSelected]() {
        
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "iPokemon"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let urlStringMain = "https://pokeapi.co/api/v2/pokemon?limit=135"
        
        apiService.fetchData(urlString: urlStringMain) { [weak self] value in
            
            guard let data = value else { return }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemons.self, from: data)
                
                pokemon.results.forEach({
                    self?.apiService.fetchData(urlString: $0.url) { [weak self] value in
                        guard let data = value else { return }
                        
                        do {
                            
                            let pokemonSelected = try JSONDecoder().decode(PokemonSelected.self, from: data)
                            self?.pokemonSelected.append(pokemonSelected)
                        }
                        catch {
                            print(error)
                            return
                        }
                    }
                })
                
                DispatchQueue.main.async {
                    
                    self?.pokemons = pokemon.results
                    self?.tableView.reloadData()
                }
            }
            catch {
                print(error)
                return
            }
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let pokemon = pokemons[indexPath.row]
        cell.textLabel?.text = pokemon.name
        
        guard indexPath.row < pokemonSelected.count else { return cell }
        let imageUrl = pokemonSelected[indexPath.row].sprites.front_default
        
        
        let resource = ImageResource(downloadURL: URL(string: imageUrl)!, cacheKey: imageUrl)
        cell.imageView?.kf.setImage(with: resource)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.pokemon = pokemons[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
