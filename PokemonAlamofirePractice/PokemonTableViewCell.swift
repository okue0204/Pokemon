//
//  PokemonTableViewCell.swift
//  PokemonAlamofirePractice
//
//  Created by 奥江英隆 on 2023/07/08.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var attributeLabel1: UILabel!
    @IBOutlet weak var attributeLabel2: UILabel!
    
    private lazy var attributeLabels = [attributeLabel1,
                                        attributeLabel2]
    
    let imageDownloader = PokemonImageDownloader.shard
    
    var pokemon: Pokemon? {
        didSet {
            guard let pokemon else {
                return
            }
            configure(pokemon: pokemon)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configure(pokemon: Pokemon) {
        guard pokemon.id == self.pokemon?.id else {
            return
        }
        pokemonImageView.image = nil
        idLabel.text = String(pokemon.id)
        nameLabel.text = pokemon.name
        attributeLabel2.isHidden = pokemon.attributes.count == 1
        pokemon.attributes.enumerated().forEach { offset, element in
            attributeLabels[offset]?.text = element.title
            attributeLabels[offset]?.textColor = element.color
        }
        imageDownloader.downloadImage(imageUrl: pokemon.imageUrl) { [weak self] result in
            switch result {
            case .success(let image):
                self?.pokemonImageView.image = image
            case .failure:
                self?.pokemonImageView.image = nil
            }
        }
    }
}
