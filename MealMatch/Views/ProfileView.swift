import SwiftUI

struct ProfileView: View {
    @State private var notificationsEnabled = true
    @State private var darkModeEnabled = false
    @State private var weeklyReminders = true

    var body: some View {
        NavigationStack {
            Form {
                // Profile Header
                Section {
                    HStack(spacing: 16) {
                        Circle()
                            .fill(MMColor.primaryFixed)
                            .frame(width: 70, height: 70)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.title)
                                    .foregroundColor(MMColor.primary)
                            )

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Alex Johnson")
                                .font(.headline)
                                .foregroundColor(MMColor.onBackground)
                            Text("MealMatch Member")
                                .font(.subheadline)
                                .foregroundColor(MMColor.onSurfaceVariant)
                        }

                        Spacer()
                    }
                    .padding(.vertical, 8)
                }

                // Stats
                Section {
                    HStack {
                        StatCard(icon: "flame.fill", value: "14", label: "Day Streak", color: MMColor.primary)
                        Divider()
                        StatCard(icon: "fork.knife", value: "42", label: "Meals Logged", color: MMColor.tertiary)
                    }
                    .frame(height: 80)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                    .padding(.horizontal, 4)

                    HStack {
                        StatCard(icon: "leaf.fill", value: "28", label: "Recipes Made", color: MMColor.primary)
                        Divider()
                        StatCard(icon: "star.fill", value: "4.8", label: "Avg. Rating", color: MMColor.secondary)
                    }
                    .frame(height: 80)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                    .padding(.horizontal, 4)
                } header: {
                    Text("Your Stats")
                }

                // Weekly Nutrition Goal
                Section {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Weekly Nutrition Goal")
                            .font(.headline)
                            .foregroundColor(MMColor.onBackground)

                        HStack(spacing: 0) {
                            NutritionBar(label: "Protein", current: 92, target: 120, unit: "g", color: MMColor.primary)
                            NutritionBar(label: "Carbs", current: 145, target: 200, unit: "g", color: MMColor.secondary)
                            NutritionBar(label: "Fats", current: 48, target: 65, unit: "g", color: MMColor.tertiary)
                        }

                        HStack(alignment: .firstTextBaseline) {
                            Text("1,420")
                                .font(.title)
                                .fontWeight(.black)
                                .foregroundColor(MMColor.primary)
                            Text("/ 2,100 kcal")
                                .font(.subheadline)
                                .foregroundColor(MMColor.onSurfaceVariant)
                        }
                    }
                    .padding(.vertical, 8)
                } header: {
                    Text("Nutrition")
                }

                // App Settings
                Section {
                    Toggle(isOn: $notificationsEnabled) {
                        Label("Notifications", systemImage: "bell.fill")
                    }
                    .tint(MMColor.primary)

                    Toggle(isOn: $weeklyReminders) {
                        Label("Weekly Meal Reminders", systemImage: "calendar")
                    }
                    .tint(MMColor.primary)

                    Toggle(isOn: $darkModeEnabled) {
                        Label("Dark Mode", systemImage: "moon.fill")
                    }
                    .tint(MMColor.primary)
                } header: {
                    Text("Settings")
                }

                // Account
                Section {
                    NavigationLink {
                        Text("Edit Profile")
                    } label: {
                        Label("Edit Profile", systemImage: "person.fill")
                    }

                    NavigationLink {
                        Text("Preferences")
                    } label: {
                        Label("Preferences", systemImage: "gear")
                    }

                    NavigationLink {
                        Text("Help & Support")
                    } label: {
                        Label("Help & Support", systemImage: "questionmark.circle.fill")
                    }
                } header: {
                    Text("Account")
                }

                // Sign Out
                Section {
                    Button(role: .destructive) {
                        // Sign out action
                    } label: {
                        Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                }
            }
            .listStyle(.insetGrouped)
            .tint(MMColor.primary)
            .background(MMColor.background)
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct StatCard: View {
    let icon: String
    let value: String
    let label: String
    let color: Color

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
            Text(value)
                .font(.title2)
                .fontWeight(.black)
                .foregroundColor(MMColor.onBackground)
            Text(label)
                .font(.caption2)
                .foregroundColor(MMColor.onSurfaceVariant)
        }
        .frame(maxWidth: .infinity)
    }
}

struct NutritionBar: View {
    let label: String
    let current: Int
    let target: Int
    let unit: String
    let color: Color

    private var progress: CGFloat {
        min(CGFloat(current) / CGFloat(target), 1.0)
    }

    var body: some View {
        VStack(spacing: 6) {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(color.opacity(0.15))
                    .frame(height: 60)
                Rectangle()
                    .fill(color)
                    .frame(height: 60 * progress)
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            Text(label)
                .font(.caption2)
                .fontWeight(.bold)
                .foregroundColor(MMColor.onSurfaceVariant)
        }
        .frame(maxWidth: .infinity)
    }
}
