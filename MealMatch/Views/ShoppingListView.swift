import SwiftUI

struct ShoppingListView: View {
    @State private var items: [ShoppingItem] = ShoppingItem.samples
    @State private var newItemText = ""
    @State private var showAddItem = false

    var groupedItems: [String: [ShoppingItem]] {
        Dictionary(grouping: items) { $0.ingredient.category }
    }

    var sortedCategories: [String] {
        Ingredient.categories.filter { groupedItems[$0] != nil }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Progress Header
                VStack(spacing: 12) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Shopping List")
                                .font(.system(size: 22, weight: .black))
                                .foregroundColor(.mmOnSurface)
                            Text("\(items.filter { $0.isChecked }.count) of \(items.count) items")
                                .font(.system(size: 13))
                                .foregroundColor(.mmOnSurfaceVariant)
                        }
                        Spacer()
                        Image(systemName: "cart.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.mmPrimary)
                    }

                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.mmSurfaceContainerLow)
                                .frame(height: 8)
                                .clipShape(Capsule())
                            Rectangle()
                                .fill(Color.mmPrimary)
                                .frame(width: geo.size.width * progress, height: 8)
                                .clipShape(Capsule())
                        }
                    }
                    .frame(height: 8)
                }
                .padding(20)
                .background(Color.mmSurfaceContainerLowest)
                .clipShape(RoundedRectangle(cornerRadius: MMRadius.card))
                .shadow(color: .black.opacity(0.04), radius: 12, x: 0, y: 4)

                // Categories
                ForEach(sortedCategories, id: \.self) { category in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: categoryIcon(for: category))
                                .foregroundColor(.mmPrimary)
                            Text(category)
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.mmOnSurface)
                            Spacer()
                            Text("\(groupedItems[category]?.filter { $0.isChecked }.count ?? 0)/\(groupedItems[category]?.count ?? 0)")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.mmOnSurfaceVariant)
                        }
                        .padding(.horizontal, 4)

                        VStack(spacing: 0) {
                            ForEach(groupedItems[category] ?? []) { item in
                                IngredientRow(item: item) {
                                    toggleItem(item)
                                }
                                if item.id != groupedItems[category]?.last?.id {
                                    Divider()
                                        .padding(.leading, 36)
                                }
                            }
                        }
                        .padding(16)
                        .background(Color.mmSurfaceContainerLowest)
                        .clipShape(RoundedRectangle(cornerRadius: MMRadius.card))
                        .shadow(color: .black.opacity(0.03), radius: 8, x: 0, y: 2)
                    }
                }

                // Add Custom Item
                VStack(spacing: 12) {
                    HStack(spacing: 12) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.mmPrimary)
                        Text("Add custom item")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.mmOnSurfaceVariant)
                        Spacer()
                    }
                    .padding(20)
                    .background(Color.mmSurfaceContainerLow.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: MMRadius.card))
                    .overlay(
                        RoundedRectangle(cornerRadius: MMRadius.card)
                            .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [8]))
                            .foregroundColor(.mmOutlineVariant.opacity(0.5))
                    )
                }
            }
            .padding(16)
            .padding(.bottom, 100)
        }
        .background(Color.mmBackground)
        .navigationTitle("Shopping")
        .navigationBarHidden(true)
    }

    private var progress: CGFloat {
        guard !items.isEmpty else { return 0 }
        return CGFloat(items.filter { $0.isChecked }.count) / CGFloat(items.count)
    }

    private func toggleItem(_ item: ShoppingItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isChecked.toggle()
        }
    }

    private func categoryIcon(for category: String) -> String {
        switch category {
        case "Produce": return "leaf.fill"
        case "Protein": return "fish.fill"
        case "Dairy": return "cup.and.saucer.fill"
        case "Pantry": return "cabinet.fill"
        case "Frozen": return "snowflake"
        default: return "circle.fill"
        }
    }
}
