import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MealPlanView()
                .tabItem {
                    Label("MealPlan", systemImage: "calendar")
                }

            RecipesView()
                .tabItem {
                    Label("Recipes", systemImage: "book")
                }

            ShoppingListView()
                .tabItem {
                    Label("Shopping", systemImage: "cart")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
        .tint(MMColor.primary)
    }
}
