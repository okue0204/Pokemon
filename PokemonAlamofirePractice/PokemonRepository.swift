//
//  PokemonRepository.swift
//  PokemonAlamofirePractice
//
//  Created by 奥江英隆 on 2023/07/08.
//

import Foundation
import SwiftyJSON

protocol PokemonRepository {
    // ポケモンの情報を取得する
    func pokemonInfo(handler: @escaping (Result<Pokemon, ApiError>) -> Void)
}

class PokemonRepositoryImpl: PokemonRepository {
    func pokemonInfo(handler: @escaping (Result<Pokemon, ApiError>) -> Void) {
        ApiRequest.shard.request { result in
            switch result {
            case .success(let json):
                do {
                    handler(.success( try Pokemon(json: json)))
                } catch let error as EntitiyCreationError {
                    handler(.failure(.illegalResponse(case: error)))
                } catch {
                    fatalError(error.localizedDescription)
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}
