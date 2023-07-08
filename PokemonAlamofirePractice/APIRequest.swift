//
//  APIRequest.swift
//  PokemonAlamofirePractice
//
//  Created by 奥江英隆 on 2023/07/08.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiRequest {
    
    static let shard = ApiRequest()
    static let baseUrl = "https://pokeapi.co/api/v2/pokemon/"
    
    private init() {}
    
    let ids = 1...100
    
    func request(handler: @escaping (Result<JSON, ApiError>) -> Void) {
        guard let url = URL(string: Self.baseUrl) else {
            return
        }
        ids.forEach { id in
            let url = url.appendingPathComponent("\(id)", isDirectory: false)
            AF.request(URLRequest(url: url)).responseData { responce in
                switch responce.result {
                case .success(let responceData):
                    if let statusCode = responce.response?.statusCode {
                        switch statusCode {
                        case 200:
                            handler(.success(JSON(responceData)))
                        case 400:
                            handler(.failure(.badRequest))
                        case 401:
                            handler(.failure(.unauthorized))
                        case 500:
                            handler(.failure(.internalServerError))
                        default:
                            handler(.failure(.internalServerError))
                        }
                    }
                case .failure:
                    handler(.failure(.internalServerError))
                }
            }
        }
    }
}

enum ApiError: Error {
    case noNetworkConnection
    case netWorkTimeOut
    case unauthorized
    case badRequest
    case internalServerError
    case unknown
    case illegalResponse(case: EntitiyCreationError)
}

struct EntitiyCreationError: Error {
    let responseJson: String
}
