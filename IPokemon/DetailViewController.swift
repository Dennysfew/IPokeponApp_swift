//
//  DetailViewController.swift
//  IPokemon
//
//  Created by Denys on 19.04.2022.
//

import UIKit

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
            
            apiService.fetchImage(urlString: imageUrl) { [weak self] value in
                guard let picture = value else { return }
                
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let dvc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//                
                DispatchQueue.main.async {
                    self?.imageView.image = picture
                   // dvc.imageOfPokemon = picture
                }
                
             

            }
            
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





