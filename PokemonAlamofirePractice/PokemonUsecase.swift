//
//  PokemonUsecase.swift
//  PokemonAlamofirePractice
//
//  Created by 奥江英隆 on 2023/07/08.
//

import Foundation

class PokemonUsecase {
    
    let repository = PokemonRepositoryImpl()
    
    func pokemonInfo(handler: @escaping (Result<Pokemon, ApiError>) -> Void) {
        repository.pokemonInfo(handler: handler)
    }
}
