import SwiftUI

struct ShoppingListView: View {
    @State private var items: [ShoppingItem] = ShoppingItem.samples
    @State private var newItemName = ""
    @State private var showAddItem = false

    private var groupedItems: [String: [ShoppingItem]] {
        Dictionary(grouping: items) { $0.ingredient.category }
    }

    private var sortedCategories: [String] {
        Ingredient.categories.filter { groupedItems[$0] != nil }
    }

    private var progress: Double {
        guard !items.isEmpty else { return 0 }
        return Double(items.filter { $0.isChecked }.count) / Double(items.count)
    }

    var body: some View {
        NavigationStack {
            List {
                // Progress Header
                Section {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Shopping List")
                                    .font(.title2)
                                    .fontWeight(.black)
                                    .foregroundColor(MMColor.onBackground)
                                Text("\(items.filter { $0.isChecked }.count) of \(items.count) items")
                                    .font(.subheadline)
                                    .foregroundColor(MMColor.onSurfaceVariant)
                            }
                            Spacer()
                            Image(systemName: "cart.fill")
                                .font(.title2)
                                .foregroundColor(MMColor.primary)
                        }

                        ProgressView(value: progress)
                            .tint(MMColor.primary)
                    }
                    .padding(.vertical, 4)
                }

                // Grouped Items by Category
                ForEach(sortedCategories, id: \.self) { category in
                    Section {
                        ForEach(groupedItems[category] ?? []) { item in
                            ShoppingItemRow(item: item) {
                                toggleItem(item)
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    deleteItem(item)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    } header: {
                        HStack {
                            Image(systemName: categoryIcon(for: category))
                                .foregroundColor(MMColor.primary)
                            Text(category)
                                .font(.headline)
                                .foregroundColor(MMColor.onBackground)
                            Spacer()
                            Text("\(groupedItems[category]?.filter { $0.isChecked }.count ?? 0)/\(groupedItems[category]?.count ?? 0)")
                                .font(.caption)
                                .foregroundColor(MMColor.onSurfaceVariant)
                        }
                    }
                }

                // Add Custom Item
                Section {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(MMColor.primary)
                        TextField("Add custom item...", text: $newItemName)
                            .textFieldStyle(.plain)
                    }
                    .onSubmit {
                        addItem()
                    }
                }
            }
            .listStyle(.insetGrouped)
            .tint(MMColor.primary)
            .background(MMColor.background)
            .navigationTitle("Shopping")
            .navigationBarTitleDisplayMode(.large)
        }
    }

    private func toggleItem(_ item: ShoppingItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isChecked.toggle()
        }
    }

    private func deleteItem(_ item: ShoppingItem) {
        items.removeAll { $0.id == item.id }
    }

    private func addItem() {
        guard !newItemName.isEmpty else { return }
        let newIngredient = Ingredient(
            name: newItemName,
            quantity: 1,
            unit: "item",
            category: "Pantry"
        )
        items.append(ShoppingItem(ingredient: newIngredient))
        newItemName = ""
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

struct ShoppingItemRow: View {
    let item: ShoppingItem
    var onToggle: () -> Void

    var body: some View {
        Button(action: onToggle) {
            HStack(spacing: 14) {
                Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .foregroundColor(item.isChecked ? MMColor.primary : MMColor.outline)

                VStack(alignment: .leading, spacing: 2) {
                    Text(item.ingredient.name)
                        .font(.body)
                        .foregroundColor(item.isChecked ? MMColor.outline : MMColor.onBackground)
                        .strikethrough(item.isChecked)

                    Text(item.ingredient.unit)
                        .font(.caption)
                        .foregroundColor(MMColor.onSurfaceVariant)
                }

                Spacer()

                Text(item.ingredient.category)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(MMColor.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(MMColor.secondaryContainer)
                    .clipShape(Capsule())
            }
        }
        .buttonStyle(.plain)
    }
}
