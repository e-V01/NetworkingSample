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
    @Published var errorMessage: String?
    
    
    init() {
        fetchPrice(coin: "ethereum")
        fetchPrice(coin: "bitcoin")
        
    }
    
    func fetchPrice(coin: String) {
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }
        print("Fetching price ...") // 1 seq
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error { // if I was to use guard statemtn then even if everything works fine it will stop there
                    print("DEBUG: Failed with \(error.localizedDescription)")
                    self.errorMessage = error.localizedDescription
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    self.errorMessage = "Bad HTTPREsponse"
                     return
                }
                
                guard httpResponse.statusCode == 200 else {
                    self.errorMessage = "Failed to fetch with status code \(httpResponse.statusCode)"
                    return
                }
                print("DEBUG: Failed to fetch with status code \(httpResponse.statusCode)")

                guard let data = data else { return }
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
                
                guard let value = jsonObject[coin] as? [String: Double] else { return }
                guard let price = value["usd"] else { return }
                
                self.coin = coin.capitalized
                self.price = "$\(price)"
                
            }
        }
        .resume()
        // necessary
    }
    
}
