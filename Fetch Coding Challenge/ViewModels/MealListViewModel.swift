//
//  MealListViewModel.swift
//  Fetch Coding Challenge
//
//  Created by Jerry Xu on 5/28/24.
//

import SwiftUI

@MainActor
class MealListViewModel: ObservableObject {
    @Published var meals = [Meal]()
    
    func fetchMeals() async {
        do {
            let fetchedMeals = try await MealService.shared.fetchDesserts()
            meals = fetchedMeals.sorted { $0.name < $1.name }
        } catch {
            print("Error fetching meals: \(error)")
        }
    }
}
