//
//  MealDetailView.swift
//  Fetch Coding Challenge
//
//  Created by Jerry Xu on 5/28/24.
//

import SwiftUI

struct MealDetailView: View {
    @StateObject private var viewModel: MealDetailViewModel
    
    init(mealID: String) {
        _viewModel = StateObject(wrappedValue: MealDetailViewModel(mealID: mealID))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let meal = viewModel.meal {
                Text(meal.name)
                    .font(.largeTitle)
                    .padding(.bottom)
                
                Text("Ingredients")
                    .font(.headline)
                
                VStack{
                    ForEach(meal.ingredients, id:\.self) { item in
                        HStack {
                            Text(item.ingredient)
                            Text(item.measurement)
                        }
                        
                    }
                }
                Text("Instructions")
                    .font(.headline)
                    .padding(.top)
                Text(meal.instructions)
            } else {
                ProgressView()
            }
        }
        .padding()
        .task {
            await viewModel.fetchMealDetail()
        }
    }
}

#Preview {
    MealDetailView(mealID: "53049")
}
