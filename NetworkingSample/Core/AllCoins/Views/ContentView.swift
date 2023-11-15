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
        VStack {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            } else {
                Text("\(viewModel.coin): \(viewModel.price)")

            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
