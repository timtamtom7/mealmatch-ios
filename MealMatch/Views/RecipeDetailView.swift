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
                        .fill(
                            LinearGradient(
                                colors: [MMColor.primary, MMColor.primaryFixed],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )

                    Image(systemName: "fork.knife.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.white.opacity(0.3))

                    VStack(alignment: .leading, spacing: 8) {
                        if let match = recipe.matchPercentage {
                            Text("\(match)% Match")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(MMColor.primary)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(MMColor.primaryFixed)
                                .clipShape(Capsule())
                        }
                        Text(recipe.name)
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.white)
                    }
                    .padding(20)
                }
                .frame(height: 240)

                VStack(spacing: 20) {
                    // Stats Row
                    HStack(spacing: 0) {
                        StatItem(icon: "timer", value: "\(recipe.cookTime)", label: "minutes")
                        Divider().frame(height: 40)
                        StatItem(icon: "person.2", value: "\(recipe.servings)", label: "servings")
                        Divider().frame(height: 40)
                        StatItem(icon: "flame", value: "\(recipe.calories)", label: "calories")
                    }
                    .padding(.vertical, 16)
                    .background(MMColor.surfaceContainerLow)
                    .clipShape(RoundedRectangle(cornerRadius: MMRadius.card))

                    // Tags
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(recipe.tags, id: \.self) { tag in
                                Text(tag)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(MMColor.onBackground)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(MMColor.surfaceContainerLow)
                                    .clipShape(Capsule())
                            }
                        }
                    }

                    // Ingredients Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Ingredients")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(MMColor.onBackground)

                        ForEach(recipe.ingredients) { ingredient in
                            HStack(spacing: 12) {
                                Image(systemName: "circle.fill")
                                    .font(.system(size: 6))
                                    .foregroundColor(MMColor.primary)
                                Text(ingredient.displayText)
                                    .font(.body)
                                    .foregroundColor(MMColor.onBackground)
                                Spacer()
                            }
                            .padding(.vertical, 4)
                        }
                    }

                    Divider()

                    // Instructions Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Instructions")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(MMColor.onBackground)

                        ForEach(Array(recipe.instructions.enumerated()), id: \.offset) { index, instruction in
                            HStack(alignment: .top, spacing: 14) {
                                Text("\(index + 1)")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(MMColor.primary)
                                    .frame(width: 24, height: 24)
                                    .background(MMColor.primaryFixed)
                                    .clipShape(Circle())
                                Text(instruction)
                                    .font(.body)
                                    .foregroundColor(MMColor.onBackground)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                .padding(20)
            }
        }
        .background(MMColor.background)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title3)
                        .foregroundColor(MMColor.outline)
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
                .font(.body)
                .foregroundColor(MMColor.primary)
            Text(value)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(MMColor.onBackground)
            Text(label)
                .font(.caption)
                .foregroundColor(MMColor.onSurfaceVariant)
        }
        .frame(maxWidth: .infinity)
    }
}
