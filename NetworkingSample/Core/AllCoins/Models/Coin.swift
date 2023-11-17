//
//  Coin.swift
//  NetworkingSample
//
//  Created by Y K on 17.11.2023.
//

import Foundation

struct Coin: Codable, Identifiable {
    let id: String
    let symbol: String
    let name: String
//    let currentPrice: Double
//    let marketCapRank: Int
}
