//
//  MealService.swift
//  Fetch Coding Challenge
//
//  Created by Jerry Xu on 5/28/24.
//

import Foundation

class MealService {
    static let shared = MealService()
    private let baseURL = "https://themealdb.com/api/json/v1/1/"
    
    func fetchDesserts() async throws -> [Meal] {
        let url = URL(string: baseURL + "filter.php?c=Dessert")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(MealsResponse.self, from: data)
        return response.meals
    }
    
    func fetchMealDetail(id: String) async throws -> MealDetail {
        let url = URL(string: baseURL + "lookup.php?i=\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(MealDetailResponse.self, from: data)
        guard let mealDetail = response.meals.first else {
            print("NOOOOO")
            throw URLError(.badServerResponse)
        }
        return mealDetail
    }
}

struct MealsResponse: Codable {
    let meals: [Meal]
}

struct MealDetailResponse: Codable {
    let meals: [MealDetail]
}
