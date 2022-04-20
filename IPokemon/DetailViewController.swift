//
//  DetailViewController.swift
//  IPokemon
//
//  Created by Denys on 19.04.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    var name: String?
    var pokemon: Pokemon?
    var pokemonSelected: PokemonSelected? {
        didSet{
            guard let imageUrl = pokemonSelected?.sprites.front_default else { return }
            fetchImage(urlString: imageUrl)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = name ?? ""
        
        guard let pokemon = pokemon else {
            return
        }
        
        fetchData(urlString: pokemon.url)
        
    }
    
    private func fetchData(urlString: String){
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
                let json = try JSONDecoder().decode(PokemonSelected.self, from: data!)
                self?.pokemonSelected = json
               
             }
             catch {
                print(error)
                return
             }
            
          
        }
    
    
        dataTask.resume()
    }
    
    private func fetchImage(urlString: String) {
        guard let url = URL(string: urlString) else{
            fatalError("some error")
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                guard let data = data, error == nil else { return }
                self.imageView.image = UIImage(data: data)
            }
            
        }
        task.resume()
    }
    
}
    




