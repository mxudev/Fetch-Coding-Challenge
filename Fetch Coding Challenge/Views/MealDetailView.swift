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
            ScrollView {
                VStack {
                    if let meal = viewModel.meal {
                        AsyncImage(url: URL(string: meal.thumbnail)) { image in
                            image.resizable()
                                .clipped()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 300)
                        .clipped()
                        
                        VStack(alignment: .leading) {
                            Text(meal.name)
                                .font(.largeTitle)
                                .padding(.bottom)
                            
                            Text("Ingredients")
                                .font(.headline)
                                .padding(.bottom)
                            
                            VStack(alignment: .leading) {
                                ForEach(meal.ingredients, id: \.self) { item in
                                    HStack {
                                        Text(item.ingredient)
                                        Spacer()
                                        Text(item.measurement)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                            Text("Instructions")
                                .font(.headline)
                                .padding(.vertical)
                            
                            Text(meal.instructions)
                        }
                        .padding(.all)
                    } else {
                        ProgressView()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchMealDetail()
        }
    }
}

#Preview {
    MealDetailView(mealID: "53049")
}
