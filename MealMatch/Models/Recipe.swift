import Foundation

struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let cookTime: Int
    let servings: Int
    let calories: Int
    let tags: [String]
    let ingredients: [Ingredient]
    let instructions: [String]
    let matchPercentage: Int?
}

extension Recipe {
    static let samples: [Recipe] = [
        Recipe(
            name: "Blueberry Almond Oats",
            cookTime: 15,
            servings: 2,
            calories: 380,
            tags: ["Vegan", "Quick"],
            ingredients: [
                Ingredient(name: "Steel-cut oats", quantity: 1, unit: "cup", category: "Pantry"),
                Ingredient(name: "Almond milk", quantity: 2, unit: "cups", category: "Dairy"),
                Ingredient(name: "Fresh blueberries", quantity: 0.5, unit: "cup", category: "Produce"),
                Ingredient(name: "Sliced almonds", quantity: 2, unit: "tbsp", category: "Pantry"),
                Ingredient(name: "Honey", quantity: 1, unit: "tbsp", category: "Pantry")
            ],
            instructions: [
                "Combine oats and almond milk in a jar.",
                "Stir in honey and let sit overnight in the fridge.",
                "In the morning, top with blueberries and almonds.",
                "Serve chilled and enjoy!"
            ],
            matchPercentage: 94
        ),
        Recipe(
            name: "Miso Glazed Salmon with Pea Puree",
            cookTime: 45,
            servings: 4,
            calories: 520,
            tags: ["High Protein", "Pescatarian"],
            ingredients: [
                Ingredient(name: "Salmon fillet", quantity: 4, unit: "pieces", category: "Protein"),
                Ingredient(name: "White miso paste", quantity: 3, unit: "tbsp", category: "Pantry"),
                Ingredient(name: "Frozen peas", quantity: 2, unit: "cups", category: "Frozen"),
                Ingredient(name: "Fresh mint", quantity: 1, unit: "handful", category: "Produce"),
                Ingredient(name: "Lemon", quantity: 1, unit: "whole", category: "Produce")
            ],
            instructions: [
                "Preheat oven to 400°F.",
                "Mix miso paste with a little honey and brush over salmon.",
                "Bake salmon for 20 minutes until caramelized.",
                "Blanch peas and blend with mint and lemon juice.",
                "Plate salmon over pea puree and serve."
            ],
            matchPercentage: 88
        ),
        Recipe(
            name: "One-Pot Garden Herb Pasta",
            cookTime: 12,
            servings: 4,
            calories: 410,
            tags: ["Vegan", "Quick"],
            ingredients: [
                Ingredient(name: "Penne pasta", quantity: 400, unit: "g", category: "Pantry"),
                Ingredient(name: "Cherry tomatoes", quantity: 2, unit: "cups", category: "Produce"),
                Ingredient(name: "Fresh basil", quantity: 1, unit: "bunch", category: "Produce"),
                Ingredient(name: "Garlic", quantity: 4, unit: "cloves", category: "Produce"),
                Ingredient(name: "Olive oil", quantity: 3, unit: "tbsp", category: "Pantry")
            ],
            instructions: [
                "Boil pasta according to package directions.",
                "Sauté garlic in olive oil until fragrant.",
                "Add halved cherry tomatoes and cook until blistered.",
                "Toss pasta with tomatoes, basil, and olive oil.",
                "Season with salt and pepper to taste."
            ],
            matchPercentage: 90
        ),
        Recipe(
            name: "Summer Harvest Bowl",
            cookTime: 15,
            servings: 2,
            calories: 320,
            tags: ["Vegan", "Quick"],
            ingredients: [
                Ingredient(name: "Mixed greens", quantity: 4, unit: "cups", category: "Produce"),
                Ingredient(name: "Strawberries", quantity: 1, unit: "cup", category: "Produce"),
                Ingredient(name: "Feta cheese", quantity: 0.5, unit: "cup", category: "Dairy"),
                Ingredient(name: "Balsamic glaze", quantity: 2, unit: "tbsp", category: "Pantry"),
                Ingredient(name: "Walnuts", quantity: 0.25, unit: "cup", category: "Pantry")
            ],
            instructions: [
                "Wash and dry mixed greens.",
                "Slice strawberries and crumble feta.",
                "Arrange greens in bowls and top with strawberries.",
                "Sprinkle feta and walnuts over the top.",
                "Drizzle with balsamic glaze and serve."
            ],
            matchPercentage: 94
        )
    ]
}
