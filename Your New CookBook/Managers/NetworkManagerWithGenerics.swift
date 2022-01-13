//
//  NetworkManagerWithGenerics.swift
//  Your New CookBook
//
//  Created by Alexis Diaz on 1/13/22.
//

import UIKit

class NetworkManagerWithGenerics {
    
    static let shared     = NetworkManagerWithGenerics()
    private let baseURL  = "https://www.themealdb.com/api/json/v1/1/"
    private let cache    = NSCache<NSString, UIImage>()
    private let decoder = JSONDecoder()
    
    private init() {}
    
  
    func getRequest<NC: Decodable>(endpoint: MealDBEndpoint) async throws -> NC {
        
        guard let url = endpoint.url else {
            throw ErrorMessages.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ErrorMessages.invalidResponse
        }

        do {
            
            return try decoder.decode(NC.self, from: data)
        } catch {
            throw ErrorMessages.invalidData
        }
    }

    func downloadImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) { return image }
        guard let url = URL(string: urlString) else { return nil }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            self.cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
    
}
