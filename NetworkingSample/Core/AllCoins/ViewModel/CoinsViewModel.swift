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
        fetchPrice()
    }
    
    func fetchPrice() {
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=ethereum&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return }
        print("Fetching price ...")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            print("Did receive data \(data)")
        }
        .resume()
        // necessary
        print("Did reach end of functon ...")
    }

}
