//
//  Pokemon.swift
//  PokemonAlamofirePractice
//
//  Created by 奥江英隆 on 2023/07/08.
//

import Foundation
import SwiftyJSON
import UIKit

struct Pokemon {
    
    enum Attribute: String {
        case normal
        case water
        case fire
        case grass
        case electric
        case ice
        case psychic
        case fighting
        case poison
        case ground
        case flying
        case bug
        case rock
        
        var title: String {
            switch self {
            case .normal:
                return "ノーマル"
            case .water:
                return "みず"
            case .fire:
                return "ほのお"
            case .grass:
                return "くさ"
            case .electric:
                return "でんき"
            case .ice:
                return "こおり"
            case .psychic:
                return "エスパー"
            case .fighting:
                return "かくとう"
            case .poison:
                return "どく"
            case .ground:
                return "じめん"
            case .flying:
                return "ひこう"
            case .bug:
                return "むし"
            case .rock:
                return "いわ"
            }
        }
        
        var color: UIColor {
            switch self {
            case .normal:
                return UIColor.gray
            case .water:
                return UIColor.blue
            case .fire:
                return UIColor.orange
            case .grass:
                return UIColor.green
            case .electric:
                return UIColor.yellow
            case .ice:
                return UIColor.cyan
            case .psychic:
                return UIColor.magenta
            case .fighting:
                return UIColor.red
            case .poison:
                return UIColor.purple
            case .ground:
                return UIColor.brown
            case .flying:
                return UIColor.cyan
            case .bug:
                return UIColor.green
            case .rock:
                return UIColor.brown
            }
        }
    }
    
    // ポケモンID
    let id: Int
    // ポケモンの名前
    let name: String
    // ポケモンのimageUrl
    let imageUrl: String
    // ポケモンのタイプ
    let attributes: [Attribute]
    
}

extension Pokemon {
    init(json: JSON) throws {
        guard let id = json["id"].int,
              let name = json["name"].string,
              let imageUrl = json["sprites"]["front_default"].string,
              let attributes = json["types"].array else {
            throw EntitiyCreationError(responseJson: json.debugDescription)
        }
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.attributes = attributes.compactMap {
            Pokemon.Attribute(rawValue: $0["type"]["name"].stringValue)
        }
    }
}
