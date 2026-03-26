import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                MealPlanView()
                    .tag(0)

                RecipesView()
                    .tag(1)

                ShoppingListView()
                    .tag(2)

                ProfileView()
                    .tag(3)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            // Custom Tab Bar
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Int

    let tabs = [
        ("home", "Home"),
        ("book.fill", "Plan"),
        ("calendar", "Recipes"),
        ("cart.fill", "List"),
        ("person.fill", "Profile")
    ]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<5, id: \.self) { index in
                Button(action: { selectedTab = index }) {
                    VStack(spacing: 4) {
                        Image(systemName: tabs[index].0)
                            .font(.system(size: 20))
                            .foregroundColor(selectedTab == index ? .white : .mmOutline)
                        Text(tabs[index].1)
                            .font(.system(size: 9, weight: .bold))
                            .foregroundColor(selectedTab == index ? .white : .mmOutline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                }
            }
        }
        .padding(.horizontal, 8)
        .padding(.top, 12)
        .padding(.bottom, 28)
        .background(
            Color.mmSurfaceContainerLowest
                .shadow(color: .black.opacity(0.08), radius: 20, x: 0, y: -4)
        )
    }
}
