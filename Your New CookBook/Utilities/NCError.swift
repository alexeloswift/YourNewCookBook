//
//  NCError.swift
//  Your New CookBook
//
//  Created by Alexis Diaz on 1/12/22.
//

import Foundation

enum ErrorMessages: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
}
extension ErrorMessages: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .unableToComplete:
            return "You should check your connection"
        case .invalidResponse:
            return "Invalid response from server"
        case .invalidData:
            return "The data recieved from server is invalid"
        }
    }
}
