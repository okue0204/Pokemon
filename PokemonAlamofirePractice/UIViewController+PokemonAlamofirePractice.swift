//
//  UIViewController+PokemonAlamofirePractice.swift
//  PokemonAlamofirePractice
//
//  Created by 奥江英隆 on 2023/07/08.
//

import Foundation
import UIKit

extension UIViewController {
    func showError(title: String?, message: String?, actioins: [UIAlertAction]) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        actioins.forEach { action in
            alert.addAction(action)
        }
        present(alert, animated: true)
    }
}
