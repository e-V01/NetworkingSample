//
//  CoinsViewModel.swift
//  NetworkingSample
//
//  Created by Y K on 15.11.2023.
//

import Foundation


class CoinsViewModel: ObservableObject {
    
    @Published var coin = ""
    @Published var price = ""
    
    init() {
        fetchPrice(coin: "ethereum")
        fetchPrice(coin: "bitcoin")

    }
    
    func fetchPrice(coin: String) {
        print(Thread.current)
        
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }
        print("Fetching price ...") // 1 seq
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            print(Thread.current)
            print("Did receive data \(data)") // 3rd seq
            
            guard let data = data else { return }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }

            guard let value = jsonObject[coin] as? [String: Double] else { return }
            guard let price = value["usd"] else { return }
            
            DispatchQueue.main.async {
                print(Thread.current)
                self.coin = coin.capitalized
                self.price = "$\(price)"
            }
            
            
//            print("JSON \(jsonObject)")
        }
        .resume()
        // necessary
        print("Did reach end of functon ...") // 2nd seq
    }

}
