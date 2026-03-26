import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Profile Header
                VStack(spacing: 16) {
                    Circle()
                        .fill(Color.mmPrimaryContainer)
                        .frame(width: 80, height: 80)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.system(size: 36))
                                .foregroundColor(.mmPrimary)
                        )

                    VStack(spacing: 4) {
                        Text("Alex Johnson")
                            .font(.system(size: 22, weight: .black))
                            .foregroundColor(.mmOnSurface)
                        Text("MealMatch Member")
                            .font(.system(size: 13))
                            .foregroundColor(.mmOnSurfaceVariant)
                    }
                }
                .padding(.vertical, 24)

                // Stats Grid
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 16),
                    GridItem(.flexible(), spacing: 16)
                ], spacing: 16) {
                    ProfileStatCard(icon: "flame.fill", value: "14", label: "Day Streak", color: .mmPrimary)
                    ProfileStatCard(icon: "fork.knife", value: "42", label: "Meals Logged", color: .mmTertiary)
                    ProfileStatCard(icon: "leaf.fill", value: "28", label: "Recipes Made", color: .mmPrimaryContainer)
                    ProfileStatCard(icon: "star.fill", value: "4.8", label: "Avg. Rating", color: .mmSecondary)
                }

                // Weekly Goal
                VStack(alignment: .leading, spacing: 16) {
                    Text("Weekly Nutrition Goal")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.mmOnSurface)

                    HStack(spacing: 0) {
                        StatBar(label: "Protein", current: 92, target: 120, unit: "g", color: .mmPrimary)
                        StatBar(label: "Carbs", current: 145, target: 200, unit: "g", color: .mmSecondary)
                        StatBar(label: "Fats", current: 48, target: 65, unit: "g", color: .mmTertiary)
                    }

                    HStack {
                        Text("1,420")
                            .font(.system(size: 28, weight: .black))
                            .foregroundColor(.mmPrimary)
                        Text("/ 2,100 kcal")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.mmOnSurfaceVariant)
                    }
                }
                .padding(20)
                .background(Color.mmSurfaceContainerLowest)
                .clipShape(RoundedRectangle(cornerRadius: MMRadius.card))
                .shadow(color: .black.opacity(0.04), radius: 12, x: 0, y: 4)

                // Settings Section
                VStack(spacing: 0) {
                    SettingsRow(icon: "person.fill", title: "Edit Profile")
                    Divider().padding(.leading, 52)
                    SettingsRow(icon: "bell.fill", title: "Notifications")
                    Divider().padding(.leading, 52)
                    SettingsRow(icon: "gear", title: "Preferences")
                    Divider().padding(.leading, 52)
                    SettingsRow(icon: "questionmark.circle.fill", title: "Help & Support")
                    Divider().padding(.leading, 52)
                    SettingsRow(icon: "rectangle.portrait.and.arrow.right", title: "Sign Out", isDestructive: true)
                }
                .background(Color.mmSurfaceContainerLowest)
                .clipShape(RoundedRectangle(cornerRadius: MMRadius.card))
                .shadow(color: .black.opacity(0.04), radius: 12, x: 0, y: 4)
            }
            .padding(16)
            .padding(.bottom, 100)
        }
        .background(Color.mmBackground)
        .navigationTitle("Profile")
        .navigationBarHidden(true)
    }
}

struct ProfileStatCard: View {
    let icon: String
    let value: String
    let label: String
    let color: Color

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(color)
            Text(value)
                .font(.system(size: 24, weight: .black))
                .foregroundColor(.mmOnSurface)
            Text(label)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.mmOnSurfaceVariant)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(Color.mmSurfaceContainerLowest)
        .clipShape(RoundedRectangle(cornerRadius: MMRadius.card))
        .shadow(color: .black.opacity(0.04), radius: 8, x: 0, y: 4)
    }
}

struct StatBar: View {
    let label: String
    let current: Int
    let target: Int
    let unit: String
    let color: Color

    var progress: CGFloat {
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
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(.mmOnSurfaceVariant)
        }
        .frame(maxWidth: .infinity)
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    var isDestructive: Bool = false

    var body: some View {
        Button(action: {}) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(isDestructive ? .mmError : .mmPrimary)
                    .frame(width: 28)
                Text(title)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(isDestructive ? .mmError : .mmOnSurface)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.mmOutline)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .buttonStyle(.plain)
    }
}
