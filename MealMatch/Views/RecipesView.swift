import SwiftUI

struct RecipesView: View {
    @State private var searchText = ""
    @State private var selectedRecipe: Recipe?

    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return Recipe.samples
        }
        return Recipe.samples.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Search Bar
                HStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.mmOutline)
                    TextField("Search recipes...", text: $searchText)
                        .font(.system(size: 15))
                }
                .padding(14)
                .background(Color.mmSurfaceContainerLow)
                .clipShape(RoundedRectangle(cornerRadius: 12))

                // Section Header
                HStack {
                    Text("Smart Matches")
                        .font(.system(size: 22, weight: .black))
                        .foregroundColor(.mmOnSurface)
                    Spacer()
                    Text("See All")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.mmPrimary)
                }

                // Recipe Grid
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 16),
                    GridItem(.flexible(), spacing: 16)
                ], spacing: 16) {
                    ForEach(filteredRecipes) { recipe in
                        RecipeCard(recipe: recipe)
                            .onTapGesture {
                                selectedRecipe = recipe
                            }
                    }
                }
            }
            .padding(16)
            .padding(.bottom, 100)
        }
        .background(Color.mmBackground)
        .navigationTitle("Recipes")
        .navigationBarHidden(true)
        .sheet(item: $selectedRecipe) { recipe in
            NavigationStack {
                RecipeDetailView(recipe: recipe)
            }
        }
    }
}
