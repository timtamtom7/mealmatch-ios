import SwiftUI

struct RecipeCard: View {
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topTrailing) {
                Rectangle()
                    .fill(LinearGradient(
                        colors: [Color.mmPrimaryContainer.opacity(0.4), Color.mmPrimaryFixed.opacity(0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                Image(systemName: "fork.knife.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.mmPrimary.opacity(0.4))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                HStack(spacing: 4) {
                    Image(systemName: "timer")
                        .font(.system(size: 11))
                    Text("\(recipe.cookTime)m")
                        .font(.system(size: 11, weight: .bold))
                }
                .foregroundColor(.mmPrimary)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(12)
            }
            .frame(height: 140)

            VStack(alignment: .leading, spacing: 8) {
                Text(recipe.name)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.mmOnSurface)
                    .lineLimit(2)

                HStack(spacing: 4) {
                    ForEach(recipe.tags.prefix(2), id: \.self) { tag in
                        Text(tag)
                            .font(.system(size: 9, weight: .bold))
                            .foregroundColor(.mmOutline)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(Color.mmSurfaceContainerLow)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                    }
                }

                if let match = recipe.matchPercentage {
                    HStack {
                        Image(systemName: "leaf.fill")
                            .font(.system(size: 10))
                        Text("\(match)% match")
                            .font(.system(size: 10, weight: .bold))
                    }
                    .foregroundColor(.mmPrimary)
                }
            }
            .padding(14)
        }
        .background(Color.mmSurfaceContainerLowest)
        .clipShape(RoundedRectangle(cornerRadius: MMRadius.card))
        .shadow(color: .black.opacity(0.04), radius: 20, x: 0, y: 8)
    }
}
