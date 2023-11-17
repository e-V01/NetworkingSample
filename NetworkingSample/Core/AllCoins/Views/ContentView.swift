//
//  ContentView.swift
//  NetworkingSample
//
//  Created by Y K on 15.11.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CoinsViewModel()
    var body: some View {
        List {
            ForEach(viewModel.coins) { coin in
                Text(coin.name)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
