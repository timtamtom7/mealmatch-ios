import SwiftUI

struct IngredientRow: View {
    let item: ShoppingItem
    var onToggle: (() -> Void)?

    var body: some View {
        Button(action: { onToggle?() }) {
            HStack(spacing: 14) {
                Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 22))
                    .foregroundColor(item.isChecked ? .mmPrimary : .mmOutline)

                VStack(alignment: .leading, spacing: 2) {
                    Text(item.ingredient.name)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(item.isChecked ? .mmOutline : .mmOnSurface)
                        .strikethrough(item.isChecked)

                    Text(item.ingredient.unit)
                        .font(.system(size: 12))
                        .foregroundColor(.mmOnSurfaceVariant)
                }

                Spacer()

                Text(item.ingredient.category)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.mmSecondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.mmSecondaryContainer)
                    .clipShape(Capsule())
            }
            .padding(.vertical, 8)
        }
        .buttonStyle(.plain)
    }
}
