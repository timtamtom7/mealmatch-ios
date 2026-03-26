import SwiftUI

struct MealCard: View {
    let meal: Meal
    var showDay: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image placeholder
            ZStack {
                Rectangle()
                    .fill(Color.mmPrimaryContainer.opacity(0.3))
                Image(systemName: "fork.knife")
                    .font(.system(size: 40))
                    .foregroundColor(.mmPrimary)
            }
            .aspectRatio(4/3, contentMode: .fill)

            VStack(alignment: .leading, spacing: 8) {
                // Tags
                HStack(spacing: 6) {
                    ForEach(meal.tags.prefix(2), id: \.self) { tag in
                        Text(tag)
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.mmPrimary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.mmPrimaryFixed)
                            .clipShape(Capsule())
                    }
                }

                // Title
                Text(meal.name)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.mmOnSurface)
                    .lineLimit(2)

                // Calories & Rating
                HStack {
                    if let rating = meal.rating {
                        HStack(spacing: 2) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 10))
                                .foregroundColor(.mmPrimary)
                            Text("\(rating, specifier: "%.1f")")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(.mmPrimary)
                        }
                    }

                    Spacer()

                    Text("View Recipe")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.mmPrimary)
                }
            }
            .padding(16)
        }
        .background(Color.mmSurfaceContainerLowest)
        .clipShape(RoundedRectangle(cornerRadius: MMRadius.card))
        .shadow(color: .black.opacity(0.04), radius: 12, x: 0, y: 4)
    }
}

struct MealCardLarge: View {
    let meal: Meal

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .bottomLeading) {
                Rectangle()
                    .fill(LinearGradient(
                        colors: [Color.mmPrimary.opacity(0.4), Color.mmPrimaryContainer.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                Image(systemName: "fork.knife")
                    .font(.system(size: 60))
                    .foregroundColor(.mmPrimary.opacity(0.3))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                LinearGradient(
                    colors: [.black.opacity(0.6), .clear],
                    startPoint: .top,
                    endPoint: .bottom
                )

                VStack(alignment: .leading, spacing: 4) {
                    Text(meal.name)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                        .lineLimit(2)
                }
                .padding(16)
            }
            .frame(height: 160)

            VStack(spacing: 12) {
                HStack {
                    Circle()
                        .fill(Color.mmPrimaryFixed)
                        .frame(width: 28, height: 28)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.system(size: 12))
                                .foregroundColor(.mmPrimary)
                        )
                    Circle()
                        .fill(Color.mmPrimaryFixed)
                        .frame(width: 28, height: 28)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.system(size: 12))
                                .foregroundColor(.mmPrimary)
                        )
                    Text("+12")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.mmOnSurfaceVariant)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.mmOutlineVariant)
                        .clipShape(Capsule())

                    Spacer()

                    HStack(spacing: 4) {
                        Image(systemName: "timer")
                            .font(.system(size: 14))
                        Text("\(meal.protein * 2) Min")
                            .font(.system(size: 11, weight: .bold))
                    }
                    .foregroundColor(.mmOnSurfaceVariant)
                }

                VStack(spacing: 4) {
                    HStack {
                        Text("Protein")
                            .font(.system(size: 13))
                            .foregroundColor(.mmOnSurfaceVariant)
                        Spacer()
                        Text("\(meal.protein)g")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.mmOnSurface)
                    }
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.mmSurfaceContainerLow)
                                .frame(height: 4)
                                .clipShape(Capsule())
                            Rectangle()
                                .fill(Color.mmPrimary)
                                .frame(width: geo.size.width * 0.75, height: 4)
                                .clipShape(Capsule())
                        }
                    }
                    .frame(height: 4)
                }

                Button(action: {}) {
                    HStack {
                        Image(systemName: "restaurant")
                        Text("Start Cooking")
                            .font(.system(size: 14, weight: .bold))
                    }
                    .foregroundColor(.mmOnPrimary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.mmPrimary)
                    .clipShape(RoundedRectangle(cornerRadius: MMRadius.card))
                }
            }
            .padding(16)
        }
        .background(Color.mmSurfaceContainerLowest)
        .clipShape(RoundedRectangle(cornerRadius: MMRadius.card))
        .shadow(color: Color.mmPrimary.opacity(0.06), radius: 16, x: 0, y: 8)
    }
}
