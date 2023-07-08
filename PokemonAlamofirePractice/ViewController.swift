//
//  ViewController.swift
//  PokemonAlamofirePractice
//
//  Created by 奥江英隆 on 2023/07/08.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let usecase = PokemonUsecase()
    
    var pokemonList: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSetting()
    }
    
    private func prepareSetting() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: PokemonTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: PokemonTableViewCell.self))
        tableView.backgroundColor = .white
    }
    
    @IBAction func acquisitionButtonDidTap(_ sender: Any) {
        usecase.pokemonInfo { [weak self] result in
            switch result {
            case .success(let pokemon):
                self?.pokemonList.append(pokemon)
                self?.tableView.reloadData()
            case .failure:
                self?.showError(title: "ポケモンセンターで回復して下さい",
                                message: "",
                                actioins: [UIAlertAction(title: "OK",
                                                         style: .default)])
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PokemonTableViewCell.self), for: indexPath) as! PokemonTableViewCell
        cell.pokemon = pokemonList[indexPath.row]
        return cell
    }
}

