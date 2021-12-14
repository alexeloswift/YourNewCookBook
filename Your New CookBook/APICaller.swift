//
//  APICaller.swift
//  Your New CookBook
//
//  Created by Alexis Diaz on 12/12/21.
//

import Foundation
import UIKit


enum ErrorMessages: String, Error {
    case invalidURL         = "Invalid URL"
    case unableToComplete   = "You should check your connection"
    case invalidResponse    = "Invalid response from server"
    case invalidData        = "The data recieved from server is invalid"
}

class APICaller {
    
  static let shared = APICaller()
    
    let mainURL = "https://www.themealdb.com/api/json/v1/1/"
    let cache   = NSCache<NSString, UIImage>()
    
    private init() {}
    
  
    func getCategories(completed: @escaping (Result<CategoryAPIResponse, ErrorMessages>) -> Void) {
        let endpoint = mainURL + "categories.php"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let categories = try decoder.decode(CategoryAPIResponse.self, from: data)
                completed(.success(categories))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func getMeals(for category: String, completed: @escaping (Result<MealAPIResponse, ErrorMessages>) -> Void) {
        let endpoint = mainURL + "filter.php?c=\(category)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                let meals = try decoder.decode(MealAPIResponse.self, from: data)
                completed(.success(meals))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
   
    func getMealDetails(for mealID: String, completed: @escaping (Result<MealDetailsAPIResponse, ErrorMessages>) -> Void) {
        let endpoint = mainURL + "lookup.php?i=\(mealID)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()

                let mealDetails = try decoder.decode(MealDetailsAPIResponse.self, from: data)
                completed(.success(mealDetails))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
                }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
    
}

