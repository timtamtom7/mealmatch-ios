import SwiftUI

extension Color {
    static let mmPrimary = Color(hex: "466729")
    static let mmPrimaryContainer = Color(hex: "7BA05B")
    static let mmOnPrimary = Color.white
    static let mmTertiary = Color(hex: "B12C16")
    static let mmBackground = Color(hex: "FAFAF5")
    static let mmSurface = Color(hex: "FAFAF5")
    static let mmSurfaceContainer = Color(hex: "EEEEF9")
    static let mmSurfaceContainerLow = Color(hex: "F4F4EF")
    static let mmSurfaceContainerLowest = Color(hex: "FFFFFF")
    static let mmOnSurface = Color(hex: "1A1C19")
    static let mmOnSurfaceVariant = Color(hex: "43493D")
    static let mmOutline = Color(hex: "74796C")
    static let mmOutlineVariant = Color(hex: "C3C8B9")
    static let mmSecondary = Color(hex: "625E51")
    static let mmSecondaryContainer = Color(hex: "E6DFCE")
    static let mmError = Color(hex: "BA1A1A")
    static let mmTertiaryContainer = Color(hex: "FDB4A6")
    static let mmPrimaryFixed = Color(hex: "C6EFA1")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

enum MMRadius {
    static let card: CGFloat = 16
    static let large: CGFloat = 32
    static let pill: CGFloat = 9999
}

enum MMSpacing {
    static let unit: CGFloat = 16
}
