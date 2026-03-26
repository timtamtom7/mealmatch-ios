import Foundation

struct Meal: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let calories: Int
    let protein: Int
    let tags: [String]
    let day: String
    let mealType: MealType
    let rating: Double?

    enum MealType: String, CaseIterable {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
        case snack = "Snack"
    }
}

extension Meal {
    static let samples: [Meal] = [
        Meal(name: "Blueberry Almond Oats", imageName: "meal_oats", calories: 380, protein: 12, tags: ["Vegan", "15 Min"], day: "Mon 12", mealType: .breakfast, rating: 4.9),
        Meal(name: "Miso Glazed Salmon with Pea Puree", imageName: "meal_salmon", calories: 520, protein: 34, tags: ["High Protein", "45 Min"], day: "Mon 12", mealType: .dinner, rating: nil),
        Meal(name: "Mediterranean Buddha Bowl", imageName: "meal_buddha", calories: 420, protein: 18, tags: ["Vegetarian", "20 Min"], day: "Tue 13", mealType: .lunch, rating: 4.8),
        Meal(name: "Summer Harvest Bowl", imageName: "meal_harvest", calories: 320, protein: 15, tags: ["Vegan", "15 Min"], day: "Wed 14", mealType: .dinner, rating: 4.7),
        Meal(name: "Lemon Zest Chicken Salad", imageName: "meal_chicken", calories: 450, protein: 38, tags: ["Keto", "20 Min"], day: "Thu 15", mealType: .lunch, rating: 4.6),
        Meal(name: "Avocado & Egg Power Toast", imageName: "meal_toast", calories: 290, protein: 14, tags: ["Breakfast", "8 Min"], day: "Fri 16", mealType: .breakfast, rating: 4.8)
    ]
}
