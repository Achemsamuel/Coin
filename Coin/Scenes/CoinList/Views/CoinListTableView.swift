//
//  CoinListTableView.swift
//  Coin
//
//  Created by Achem Samuel on 3/13/25.
//
import UIKit
import SwiftUI

struct CoinTableView: UIViewControllerRepresentable {
    @Binding var path: NavigationPath
    var coins: [Coin]
    var localRepo: CoinsDataLocalRepository
    var willDisplay: actionArg<Coin>? = nil
    
    func makeUIViewController(context: Context) -> CoinListViewController {
        let viewController = CoinListViewController()
        viewController.updateCoins(coins)
        viewController.didTapCoin = didTapCoin
        viewController.willDisplay = willDisplay
        viewController.localRepo = localRepo
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: CoinListViewController, context: Context) {
        uiViewController.updateCoins(coins)
    }
    
    private func didTapCoin(with coin: Coin) {
        localRepo.selectedCoin = coin
        path.append(NavigationItem.coinDetails(coin: coin))
    }
}

final class CoinListViewController: UITableViewController {
    var coins: [Coin] = []
    var didTapCoin: actionArg<Coin>?
    var willDisplay: actionArg<Coin>?
    var localRepo: CoinsDataLocalRepository?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tableView.estimatedRowHeight = 80
    }
    
    func updateCoins(_ newCoins: [Coin]) {
        self.coins = newCoins
        reloadTableView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.reuseIdentifier, for: indexPath) as? CoinTableViewCell else {
            return UITableViewCell()
        }
        cell.coin = coins[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = coins[indexPath.row]
        didTapCoin?(coin)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let coin = coins[indexPath.row]
        willDisplay?(coin)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let coin = coins[indexPath.row]
        let favoriteAction = UIContextualAction(style: .normal, title: "") { [weak self] _, _, completionHandler in
            guard let self else { return }
            toggleFavorites(with: coin.uuid, at: indexPath)
            completionHandler(true)
        }
        
        let isFavorite = localRepo?.isFavorite(id: coin.uuid) ?? false
        let favoriteImage = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        favoriteAction.image = favoriteImage
        favoriteAction.backgroundColor = .accent
        
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
    
    private func toggleFavorites(with id: String, at indexPath: IndexPath) {
        localRepo?.toggleFavorite(with: id)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
