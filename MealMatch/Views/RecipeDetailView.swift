import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Hero Image
                ZStack(alignment: .bottomLeading) {
                    Rectangle()
                        .fill(LinearGradient(
                            colors: [Color.mmPrimary, Color.mmPrimaryContainer],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                    Image(systemName: "fork.knife.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.white.opacity(0.3))

                    VStack(alignment: .leading, spacing: 8) {
                        if let match = recipe.matchPercentage {
                            Text("\(match)% Match")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.mmPrimary)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.mmPrimaryFixed)
                                .clipShape(Capsule())
                        }
                        Text(recipe.name)
                            .font(.system(size: 26, weight: .black))
                            .foregroundColor(.white)
                    }
                    .padding(20)
                }
                .frame(height: 240)

                VStack(spacing: 24) {
                    // Stats Row
                    HStack(spacing: 0) {
                        StatItem(icon: "timer", value: "\(recipe.cookTime)", label: "minutes")
                        Divider().frame(height: 40)
                        StatItem(icon: "person.2", value: "\(recipe.servings)", label: "servings")
                        Divider().frame(height: 40)
                        StatItem(icon: "flame", value: "\(recipe.calories)", label: "calories")
                    }
                    .padding(.vertical, 16)
                    .background(Color.mmSurfaceContainerLow)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    // Tags
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(recipe.tags, id: \.self) { tag in
                                Text(tag)
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(.mmOnSurface)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.mmSurfaceContainerLow)
                                    .clipShape(Capsule())
                            }
                        }
                    }

                    // Ingredients
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Ingredients")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.mmOnSurface)

                        ForEach(recipe.ingredients) { ingredient in
                            HStack(spacing: 12) {
                                Image(systemName: "circle.fill")
                                    .font(.system(size: 6))
                                    .foregroundColor(.mmPrimary)
                                Text(ingredient.displayText)
                                    .font(.system(size: 15))
                                    .foregroundColor(.mmOnSurface)
                                Spacer()
                            }
                            .padding(.vertical, 6)
                        }
                    }

                    // Instructions
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Instructions")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.mmOnSurface)

                        ForEach(Array(recipe.instructions.enumerated()), id: \.offset) { index, instruction in
                            HStack(alignment: .top, spacing: 14) {
                                Text("\(index + 1)")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(.mmPrimary)
                                    .frame(width: 24, height: 24)
                                    .background(Color.mmPrimaryFixed)
                                    .clipShape(Circle())
                                Text(instruction)
                                    .font(.system(size: 15))
                                    .foregroundColor(.mmOnSurface)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.vertical, 6)
                        }
                    }
                }
                .padding(20)
            }
        }
        .background(Color.mmBackground)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.mmOutline)
                }
            }
        }
    }
}

struct StatItem: View {
    let icon: String
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.mmPrimary)
            Text(value)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.mmOnSurface)
            Text(label)
                .font(.system(size: 11))
                .foregroundColor(.mmOnSurfaceVariant)
        }
        .frame(maxWidth: .infinity)
    }
}
