//
//  DetailViewController.swift
//  IPokemon
//
//  Created by Denys on 19.04.2022.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    

    let apiService: APIService = APIService()
    
    var pokemon: Pokemon?
    
    var pokemonSelected: PokemonSelected? {
        didSet{
            
            guard let pokemonName = pokemonSelected?.name else { return }
            guard let pokemonWeight = pokemonSelected?.weight else { return }
            guard let pokemonHeight = pokemonSelected?.height else { return }
            
            DispatchQueue.main.async {
                self.nameLbl.text = String(pokemonName)
                self.weightLbl.text = String(pokemonWeight)
                self.heightLbl.text = String(pokemonHeight)
                
            }
            
            guard let imageUrl = pokemonSelected?.sprites.front_default else { return }
            
            let resource = ImageResource(downloadURL: URL(string: imageUrl)!, cacheKey: imageUrl)
            imageView?.kf.setImage(with: resource)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let pokemon = pokemon else { return }
        
        apiService.fetchData(urlString: pokemon.url) { [weak self] value in
            guard let data = value else { return }
            
            do {
                
                let pokemonSelected = try JSONDecoder().decode(PokemonSelected.self, from: data)
                
                DispatchQueue.main.async {
                    
                    self?.pokemonSelected = pokemonSelected
                    
                }
            }
            catch {
                print(error)
                return
            }
        }
        
    }
    
}





