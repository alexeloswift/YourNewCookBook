//
//  MealModel.swift
//  Your New CookBook
//
//  Created by Alexis Diaz on 1/12/22.
//

import Foundation

struct MealAPIResponse: Codable {
    let meals: [Meal]
}

struct Meal: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
