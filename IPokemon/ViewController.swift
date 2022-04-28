//
//  ViewController.swift
//  IPokemon
//
//  Created by Denys on 13.04.2022.
//

import UIKit

class ViewController: UITableViewController {
    var pokemons = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "iPokemon"
        
        let urlStringMain = "https://pokeapi.co/api/v2/pokemon?limit=135"
        fetchDataPokemon(urlString: urlStringMain)
    }

    
    private func fetchDataPokemon(urlString: String){
        let url = URL(string: urlString)
        
        guard url != nil else {
            return
        }
        
        let defaultSession = URLSession(configuration: .default)
        
        let dataTask = defaultSession.dataTask(with: url!) { [weak self] (data:Data?,response: URLResponse?, error: Error?) in
            
            if (error != nil) {
                print(error!)
                return
                }
            
            do {
                let json = try JSONDecoder().decode(Pokemons.self, from: data!)
    
                DispatchQueue.main.async {
                    self?.pokemons = json.results
                    self?.tableView.reloadData()
                }
             }
             catch {
                print(error)
                return
             }
        }
        dataTask.resume()
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
