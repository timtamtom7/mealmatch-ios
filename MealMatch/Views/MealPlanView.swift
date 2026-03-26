import SwiftUI

struct MealPlanView: View {
    @State private var selectedDay = 0

    let days = ["Mon 12", "Tue 13", "Wed 14", "Thu 15", "Fri 16", "Sat 17", "Sun 18"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Hero Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Weekly Harvest")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.mmPrimary)
                        .tracking(2)

                    Text("Your Sunday")
                        .font(.system(size: 42, weight: .black))
                        .foregroundColor(.mmOnSurface)
                    + Text(" Inspiration.")
                        .font(.system(size: 42, weight: .black))
                        .foregroundColor(.mmPrimary)
                        .italic()

                    Text("Curating seasonal flavors for your week ahead. Balance your plate with earth-grown ingredients.")
                        .font(.system(size: 15))
                        .foregroundColor(.mmOnSurfaceVariant)
                        .padding(.top, 8)
                }
                .padding(.horizontal, 16)

                // Day Selector
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(0..<days.count, id: \.self) { index in
                            Button(action: { selectedDay = index }) {
                                Text(days[index])
                                    .font(.system(size: 13, weight: selectedDay == index ? .bold : .semibold))
                                    .foregroundColor(selectedDay == index ? .white : .mmOnSurfaceVariant)
                                    .padding(.horizontal, 18)
                                    .padding(.vertical, 12)
                                    .background(selectedDay == index ? Color.mmPrimary : Color.mmSurfaceContainerLow)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }

                // Meal Slots
                VStack(alignment: .leading, spacing: 32) {
                    // Breakfast
                    MealSlotView(
                        title: "Breakfast",
                        time: "08:00 AM",
                        icon: "sun.max.fill",
                        meals: Meal.samples.filter { $0.mealType == .breakfast }
                    )

                    // Lunch
                    MealSlotView(
                        title: "Lunch",
                        time: "12:30 PM",
                        icon: "leaf.fill",
                        meals: Meal.samples.filter { $0.mealType == .lunch }
                    )

                    // Dinner
                    MealSlotView(
                        title: "Dinner",
                        time: "07:00 PM",
                        icon: "moon.stars.fill",
                        meals: Meal.samples.filter { $0.mealType == .dinner }
                    )
                }
                .padding(.horizontal, 16)

                // Ripeness Alert
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.mmTertiary)
                        Text("RIPENESS ALERT")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.mmTertiary)
                    }

                    Text("Ingredients Expiring Soon")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.mmOnSurface)

                    Text("Don't let your harvest go to waste. Use your Baby Spinach and Avocado within the next 24 hours.")
                        .font(.system(size: 13))
                        .foregroundColor(.mmOnSurfaceVariant)
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.mmSurfaceContainerLow)
                .clipShape(RoundedRectangle(cornerRadius: MMRadius.card))
                .padding(.horizontal, 16)
            }
            .padding(.vertical, 24)
            .padding(.bottom, 100)
        }
        .background(Color.mmBackground)
        .navigationTitle("MealPlan")
        .navigationBarHidden(true)
    }
}

struct MealSlotView: View {
    let title: String
    let time: String
    let icon: String
    let meals: [Meal]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 14))
                    .foregroundColor(.mmPrimary)
                Text(title)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.mmOnSurface)
                Spacer()
                Text(time)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.mmOutline)
            }

            if meals.isEmpty {
                EmptyMealSlot()
            } else {
                ForEach(meals.prefix(1)) { meal in
                    MealCard(meal: meal)
                }
            }
        }
    }
}

struct EmptyMealSlot: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 32))
                .foregroundColor(.mmPrimary)
            Text("Add a Match")
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.mmOnSurface)
            Text("Find a recipe that perfectly fits your nutritional goals today.")
                .font(.system(size: 12))
                .foregroundColor(.mmOnSurfaceVariant)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .background(Color.mmSurfaceContainerLow.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: MMRadius.card))
        .overlay(
            RoundedRectangle(cornerRadius: MMRadius.card)
                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [8]))
                .foregroundColor(.mmOutlineVariant.opacity(0.3))
        )
    }
}
