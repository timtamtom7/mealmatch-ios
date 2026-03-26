import Foundation

struct Ingredient: Identifiable {
    let id = UUID()
    let name: String
    let quantity: Double
    let unit: String
    let category: String
}

extension Ingredient {
    var displayText: String {
        if quantity == Double(Int(quantity)) {
            return "\(Int(quantity)) \(unit) \(name)"
        } else {
            return "\(quantity) \(unit) \(name)"
        }
    }
}

extension Ingredient {
    static let categories = ["Produce", "Protein", "Dairy", "Pantry", "Frozen"]

    static let samples: [Ingredient] = [
        Ingredient(name: "Steel-cut oats", quantity: 1, unit: "cup", category: "Pantry"),
        Ingredient(name: "Almond milk", quantity: 2, unit: "cups", category: "Dairy"),
        Ingredient(name: "Fresh blueberries", quantity: 0.5, unit: "cup", category: "Produce"),
        Ingredient(name: "Salmon fillet", quantity: 4, unit: "pieces", category: "Protein"),
        Ingredient(name: "Cherry tomatoes", quantity: 2, unit: "cups", category: "Produce"),
        Ingredient(name: "Fresh basil", quantity: 1, unit: "bunch", category: "Produce"),
        Ingredient(name: "Feta cheese", quantity: 0.5, unit: "cup", category: "Dairy"),
        Ingredient(name: "Olive oil", quantity: 3, unit: "tbsp", category: "Pantry"),
        Ingredient(name: "Frozen peas", quantity: 2, unit: "cups", category: "Frozen"),
        Ingredient(name: "Baby spinach", quantity: 4, unit: "cups", category: "Produce")
    ]
}
