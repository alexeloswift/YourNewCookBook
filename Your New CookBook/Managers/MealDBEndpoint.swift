//
//  MealDBEndpoint.swift
//  Your New CookBook
//
//  Created by Alexis Diaz on 1/14/22.
//

import Foundation

struct MealDBEndpoint {
    var path: String
    var queryItems: [URLQueryItem]
}

extension MealDBEndpoint {
    static func categories() -> MealDBEndpoint {
        return MealDBEndpoint(
            path: "categories.php",
            queryItems: []
        )
    }

    static func meals(by category: String) -> MealDBEndpoint {
        return MealDBEndpoint(
            path: "filter.php",
            queryItems: [
                URLQueryItem(name: "c", value: category)
            ]
        )
    }

    static func mealDetails(mealID: String) -> MealDBEndpoint {
        return MealDBEndpoint(
            path: "lookup.php",
            queryItems: [
                URLQueryItem(name: "i", value: mealID)
            ]
        )
    }
}

extension MealDBEndpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.themealdb.com"
        components.path = "/api/json/v1/1/" + path
        components.queryItems = queryItems

        return components.url
    }
}

