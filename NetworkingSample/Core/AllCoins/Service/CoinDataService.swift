//
//  CoinDataService.swift
//  NetworkingSample
//
//  Created by Y K on 15.11.2023.
//

import Foundation

class CoinDataService {
    
    let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=200&page=1&sparkline=false&price_change_percentage=24h&locale=en"
    // Service is responsible primarily to fetch info from an API and then service gives it to the viewModel

    func fetchCoinsWithResult(completion: @escaping(Result<[Coin], CoinAPIError>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.unknownError(error: error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed(description: "Request failed")))
                 return
            }
            
            guard httpResponse.statusCode == 200 else {
                completion(.failure(.invalidStatusCode(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                completion(.success(coins))
            } catch {
                print("DEBUG: Failed to decode with error \(error)")
                completion(.failure(.jsonParsingFailure))
            }
        }.resume()
    }
    
    
    func fetchCoins(completion: @escaping([Coin]?, Error?) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else { return }
            
            guard let coins = try? JSONDecoder().decode([Coin].self, from: data) else {
                print("DEBUG: Failed to decode coins")
                return
                
            }
            completion(coins, nil)
            print("DEBUG: Coins decoded \(coins)")
        }.resume()
    }
    
    func fetchPrice(coin: String, completion: @escaping(Double) -> Void) { // custom completion handler
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }
        print("Fetching price ...") // 1 seq
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error { // if I was to use guard statemtn then even if everything works fine it will stop there
                print("DEBUG: Failed with \(error.localizedDescription)")
//                    self.errorMessage = error.localizedDescription
                return
            }
            
            
//            print("DEBUG: Failed to fetch with status code \(httpResponse.statusCode)")

            guard let data = data else { return }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            
            guard let value = jsonObject[coin] as? [String: Double] else { return }
            guard let price = value["usd"] else { return }
            
//                self.coin = coin.capitalized
//                self.price = "$\(price)"
            print("DEBUG: Price in service is \(price)")
            completion(price)
        }
        .resume()
        // necessary
    }

}
