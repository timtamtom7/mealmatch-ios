import SwiftUI

// MARK: - Design Tokens (Stitch)
enum MMColor {
    static let primary = Color(hex: "466729")        // #466729 green
    static let tertiary = Color(hex: "B12C16")       // #B12C16 orange/red
    static let background = Color(hex: "FAFAF5")      // #FAFAF5 warm off-white
    static let secondary = Color(hex: "625E51")       // #625E51
    static let error = Color(hex: "BA1A1A")           // #BA1A1A
    static let onPrimary = Color.white
    static let onBackground = Color(hex: "1A1C19")
    static let onSurfaceVariant = Color(hex: "43493D")
    static let outline = Color(hex: "74796C")
    static let surfaceContainerLow = Color(hex: "F4F4EF")
    static let surfaceContainerLowest = Color(hex: "FFFFFF")
    static let primaryFixed = Color(hex: "C6EFA1")
    static let secondaryContainer = Color(hex: "E6DFCE")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:  (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:  (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:  (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB, red: Double(r)/255, green: Double(g)/255, blue: Double(b)/255, opacity: Double(a)/255)
    }
}

enum MMRadius {
    static let card: CGFloat = 16
}
