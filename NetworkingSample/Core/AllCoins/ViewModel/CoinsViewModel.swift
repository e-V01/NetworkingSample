//
//  CoinsViewModel.swift
//  NetworkingSample
//
//  Created by Y K on 15.11.2023.
//

import Foundation


class CoinsViewModel: ObservableObject {
    
    @Published var coins = [Coin]()
    
    private let service = CoinDataService()
    
    init() {
       fetchCoins()
        
    }
    
    // receives that info from Service(fetchCoins) and here we hop back to main thread. Keeps code modular, testable and reusable
    func fetchCoins() {
        service.fetchCoins { coins in
            DispatchQueue.main.async {
                self.coins = coins
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
