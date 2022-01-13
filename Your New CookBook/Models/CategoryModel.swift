//
//  CategoryModel.swift
//  Your New CookBook
//
//  Created by Alexis Diaz on 1/12/22.
//

import Foundation

struct CategoryAPIResponse: Codable {
    let categories: [Category]
}

struct Category: Codable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}
