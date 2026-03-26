import SwiftUI

struct MealPlanView: View {
    @State private var selectedDayIndex = 0

    let days = ["Mon 12", "Tue 13", "Wed 14", "Thu 15", "Fri 16", "Sat 17", "Sun 18"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Hero Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("WEEKLY HARVEST")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(MMColor.primary)
                            .tracking(2)

                        Text("Your Sunday")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .foregroundColor(MMColor.onBackground)
                        +
                        Text(" Inspiration.")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .foregroundColor(MMColor.primary)
                            .italic()

                        Text("Curating seasonal flavors for your week ahead. Balance your plate with earth-grown ingredients.")
                            .font(.subheadline)
                            .foregroundColor(MMColor.onSurfaceVariant)
                            .padding(.top, 4)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                    // Native iOS Calendar Strip
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(Array(days.enumerated()), id: \.offset) { index, day in
                                Button {
                                    selectedDayIndex = index
                                } label: {
                                    Text(day)
                                        .font(.subheadline)
                                        .fontWeight(selectedDayIndex == index ? .bold : .semibold)
                                        .foregroundColor(selectedDayIndex == index ? .white : MMColor.onSurfaceVariant)
                                        .padding(.horizontal, 18)
                                        .padding(.vertical, 12)
                                        .background(
                                            selectedDayIndex == index
                                                ? MMColor.primary
                                                : MMColor.surfaceContainerLow
                                        )
                                        .clipShape(Capsule())
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 16)
                    }

                    // Meal Slots via native List
                    VStack(alignment: .leading, spacing: 20) {
                        MealSlotSection(
                            title: "Breakfast",
                            time: "08:00 AM",
                            systemImage: "sun.max.fill",
                            meals: Meal.samples.filter { $0.mealType == .breakfast }
                        )

                        MealSlotSection(
                            title: "Lunch",
                            time: "12:30 PM",
                            systemImage: "leaf.fill",
                            meals: Meal.samples.filter { $0.mealType == .lunch }
                        )

                        MealSlotSection(
                            title: "Dinner",
                            time: "07:00 PM",
                            systemImage: "moon.stars.fill",
                            meals: Meal.samples.filter { $0.mealType == .dinner }
                        )
                    }
                    .padding(.horizontal, 16)

                    // Ripeness Alert Card
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(MMColor.tertiary)
                            Text("RIPENESS ALERT")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(MMColor.tertiary)
                        }

                        Text("Ingredients Expiring Soon")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(MMColor.onBackground)

                        Text("Don't let your harvest go to waste. Use your Baby Spinach and Avocado within the next 24 hours.")
                            .font(.subheadline)
                            .foregroundColor(MMColor.onSurfaceVariant)
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(MMColor.surfaceContainerLow)
                    .clipShape(RoundedRectangle(cornerRadius: MMRadius.card))
                    .padding(.horizontal, 16)
                }
                .padding(.bottom, 24)
            }
            .background(MMColor.background)
            .navigationTitle("MealPlan")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct MealSlotSection: View {
    let title: String
    let time: String
    let systemImage: String
    let meals: [Meal]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: systemImage)
                    .foregroundColor(MMColor.primary)
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(MMColor.onBackground)
                Spacer()
                Text(time)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(MMColor.outline)
            }

            if meals.isEmpty {
                EmptyMealSlot()
            } else {
                ForEach(meals) { meal in
                    NavigationLink(destination: RecipeDetailView(recipe: Recipe.samples.first!)) {
                        MealCardRow(meal: meal)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

struct MealCardRow: View {
    let meal: Meal

    var body: some View {
        HStack(spacing: 0) {
            // Image placeholder
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(MMColor.primaryFixed.opacity(0.3))
                Image(systemName: "fork.knife")
                    .font(.title2)
                    .foregroundColor(MMColor.primary)
            }
            .frame(width: 80, height: 80)

            VStack(alignment: .leading, spacing: 6) {
                Text(meal.name)
                    .font(.headline)
                    .foregroundColor(MMColor.onBackground)
                    .lineLimit(2)

                HStack(spacing: 8) {
                    HStack(spacing: 2) {
                        Image(systemName: "flame.fill")
                            .font(.caption2)
                        Text("\(meal.calories) kcal")
                            .font(.caption)
                    }
                    .foregroundColor(MMColor.onSurfaceVariant)

                    if let rating = meal.rating {
                        HStack(spacing: 2) {
                            Image(systemName: "star.fill")
                                .font(.caption2)
                                .foregroundColor(MMColor.primary)
                            Text("\(rating, specifier: "%.1f")")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(MMColor.primary)
                        }
                    }
                }

                HStack(spacing: 4) {
                    ForEach(meal.tags.prefix(2), id: \.self) { tag in
                        Text(tag)
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(MMColor.primary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(MMColor.primaryFixed)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.leading, 12)
            .padding(.vertical, 8)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(MMColor.outline)
        }
        .padding(12)
        .background(MMColor.surfaceContainerLowest)
        .clipShape(RoundedRectangle(cornerRadius: MMRadius.card))
    }
}

struct EmptyMealSlot: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "plus.circle.fill")
                .font(.largeTitle)
                .foregroundColor(MMColor.primary)
            Text("Add a Match")
                .font(.headline)
                .foregroundColor(MMColor.onBackground)
            Text("Find a recipe that perfectly fits your nutritional goals today.")
                .font(.caption)
                .foregroundColor(MMColor.onSurfaceVariant)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 160)
        .background(MMColor.surfaceContainerLow.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: MMRadius.card))
        .overlay(
            RoundedRectangle(cornerRadius: MMRadius.card)
                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [8]))
                .foregroundColor(MMColor.outline.opacity(0.3))
        )
    }
}
