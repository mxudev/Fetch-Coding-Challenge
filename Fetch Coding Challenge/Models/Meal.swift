//
//  Meal.swift
//  Fetch Coding Challenge
//
//  Created by Jerry Xu on 5/28/24.
//

import Foundation

struct Meal: Identifiable, Codable {
    let id: String
    let name: String
    let thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnail = "strMealThumb"
    }
}

struct MealDetail: Codable {
    let id: String
    let name: String
    let instructions: String
    let thumbnail: String
    let ingredients: [Ingredient]
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
        case thumbnail = "strMealThumb"
    }
    
    private struct AdditionalKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        instructions = try container.decode(String.self, forKey: .instructions)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
        
        let additionalContainer = try decoder.container(keyedBy: AdditionalKeys.self)
        var tempIngredients: [Ingredient] = []
        
        for index in 1...20 {
            let ingredientKey = "strIngredient\(index)"
            let measureKey = "strMeasure\(index)"
            
            let ingredient = try additionalContainer.decode(String.self, forKey: AdditionalKeys(stringValue: ingredientKey)!)
            let measurement = try additionalContainer.decode(String.self, forKey: AdditionalKeys(stringValue: measureKey)!)
            
            if !ingredient.isEmpty && !measurement.isEmpty {
                let newIngredient = Ingredient(ingredient: ingredient, measurement: measurement)
                tempIngredients.append(newIngredient)
            }
        }
        ingredients = tempIngredients
    }
}


struct Ingredient: Identifiable, Hashable {
    let id = UUID()
    let ingredient: String
    let measurement: String
    
}
