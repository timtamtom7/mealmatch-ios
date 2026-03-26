import Foundation

struct ShoppingItem: Identifiable {
    let id = UUID()
    let ingredient: Ingredient
    var isChecked: Bool

    init(ingredient: Ingredient, isChecked: Bool = false) {
        self.ingredient = ingredient
        self.isChecked = isChecked
    }
}

extension ShoppingItem {
    static let samples: [ShoppingItem] = Ingredient.samples.map { ShoppingItem(ingredient: $0) }
}
