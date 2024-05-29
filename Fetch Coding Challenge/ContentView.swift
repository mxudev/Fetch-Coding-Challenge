//
//  ContentView.swift
//  Fetch Coding Challenge
//
//  Created by Jerry Xu on 5/28/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MealListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.meals) { meal in
                NavigationLink(destination: MealDetailView(mealID: meal.id)) {
                    HStack {
                        AsyncImage(url: URL(string: meal.thumbnail)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        
                        Text(meal.name)
                    }
                }
            }
            .navigationTitle("Desserts")
            .refreshable {
                await viewModel.fetchMeals()
            }
        }
        .task {
            await viewModel.fetchMeals()
        }
    }
}

#Preview {
    ContentView()
}
