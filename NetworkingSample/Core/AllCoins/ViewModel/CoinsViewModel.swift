//
//  CoinsViewModel.swift
//  NetworkingSample
//
//  Created by Y K on 15.11.2023.
//

import Foundation


class CoinsViewModel: ObservableObject {
    
    @Published var coins = [Coin]()
    @Published var errorMessage: String?

    private let service = CoinDataService()
    
    init() {
       fetchCoins()
        
    }
    
    // receives that info from Service(fetchCoins) and here we hop back to main thread. Keeps code modular, testable and reusable
    func fetchCoins() {
//        service.fetchCoins { coins, error in
//            DispatchQueue.main.async {
//                if let error = error {
//                    self.errorMessage = error.localizedDescription
//                    return
//                }
//                self.coins = coins ?? []
//            }
//            
//        }
        service.fetchCoinsWithResult { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coins):
                    self.coins = coins
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

//    func fetchPrice(coin: String) {
//        service.fetchPrice(coin: coin) { priceFromService in
//            DispatchQueue.main.async {
//                self.price = "$\(priceFromService)"
//                self.coin = coin.capitalized
//            }
//        }
//    }
