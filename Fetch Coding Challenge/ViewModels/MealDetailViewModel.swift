//
//  MealDetailViewModel.swift
//  Fetch Coding Challenge
//
//  Created by Jerry Xu on 5/28/24.
//
import SwiftUI

@MainActor
class MealDetailViewModel: ObservableObject {
    @Published var meal: MealDetail?
    private let mealID: String
    
    init(mealID: String) {
        self.mealID = mealID
    }
    
    func fetchMealDetail() async {
        do {
            meal = try await MealService.shared.fetchMealDetail(id: mealID)
        } catch {
            print("Error fetching meal detail: \(error)")
        }
    }
}
