//
//  PokemonImageDownloader.swift
//  PokemonAlamofirePractice
//
//  Created by 奥江英隆 on 2023/07/08.
//

import Foundation
import AlamofireImage
import UIKit

class PokemonImageDownloader {
    
    static let shard = PokemonImageDownloader()
    private init() {}
    
    let downloader = ImageDownloader()
    
    func downloadImage(imageUrl: String, completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: imageUrl) else {
            return
        }
        
        downloader.download(URLRequest(url: url), completion: { responce in
            switch responce.result {
            case .success(let image):
                completionHandler(.success(image))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
}
