import SwiftUI

struct RecipesView: View {
    @State private var searchText = ""
    @State private var selectedRecipe: Recipe?

    private var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return Recipe.samples
        }
        return Recipe.samples.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 20) {
                    // Section Header
                    HStack {
                        Text("Smart Matches")
                            .font(.title2)
                            .fontWeight(.black)
                            .foregroundColor(MMColor.onBackground)
                        Spacer()
                        Text("See All")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(MMColor.primary)
                    }

                    // Recipe Grid
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(filteredRecipes) { recipe in
                            Button {
                                selectedRecipe = recipe
                            } label: {
                                RecipeCardGrid(recipe: recipe)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 24)
            }
            .background(MMColor.background)
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $searchText, prompt: "Search recipes...")
            .sheet(item: $selectedRecipe) { recipe in
                NavigationStack {
                    RecipeDetailView(recipe: recipe)
                }
            }
        }
    }
}

struct RecipeCardGrid: View {
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Hero image area
            ZStack(alignment: .topTrailing) {
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [MMColor.primaryFixed.opacity(0.4), MMColor.primaryFixed.opacity(0.2)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                Image(systemName: "fork.knife.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(MMColor.primary.opacity(0.4))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                // Cook time badge
                HStack(spacing: 4) {
                    Image(systemName: "timer")
                        .font(.caption2)
                    Text("\(recipe.cookTime)m")
                        .font(.caption2)
                        .fontWeight(.bold)
                }
                .foregroundColor(MMColor.primary)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(10)
            }
            .frame(height: 140)

            VStack(alignment: .leading, spacing: 6) {
                Text(recipe.name)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(MMColor.onBackground)
                    .lineLimit(2)

                HStack(spacing: 4) {
                    ForEach(recipe.tags.prefix(2), id: \.self) { tag in
                        Text(tag)
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(MMColor.outline)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(MMColor.surfaceContainerLow)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                    }
                }

                if let match = recipe.matchPercentage {
                    HStack(spacing: 2) {
                        Image(systemName: "leaf.fill")
                            .font(.caption2)
                        Text("\(match)% match")
                            .font(.caption2)
                            .fontWeight(.bold)
                    }
                    .foregroundColor(MMColor.primary)
                }
            }
            .padding(12)
        }
        .background(MMColor.surfaceContainerLowest)
        .clipShape(RoundedRectangle(cornerRadius: MMRadius.card))
        .shadow(color: .black.opacity(0.04), radius: 12, x: 0, y: 4)
    }
}
