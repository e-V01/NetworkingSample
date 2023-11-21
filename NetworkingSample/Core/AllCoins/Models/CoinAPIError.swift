//
//  CoinAPIError.swift
//  NetworkingSample
//
//  Created by Y K on 21.11.2023.
//

import Foundation

enum CoinAPIError: Error {
    case invalidData
    case jsonParsingFailure
    case requestFailed(description: String) // assosiated value
    case invalidStatusCode(statusCode: Int)
    case unknownError(error: Error)
    
    var customDescription: String {
        switch self {
        case .invalidData:
            return "Invalid data"
        case .jsonParsingFailure:
            return "Failed to parse JSON"
        case let .requestFailed(description):
            return "Request failed: \(description)"
        case let .invalidStatusCode(statusCode):
            return "Invalid status code: \(statusCode)"
        case let .unknownError(error):
            return "An unknown error occured \(error.localizedDescription)"
        }
    }

}
