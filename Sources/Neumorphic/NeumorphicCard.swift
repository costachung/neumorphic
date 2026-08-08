import SwiftUI

/// Applies a raised neumorphic card surface to any view.
public extension View {
    func neumorphicCard<S: Shape>(_ shape: S = RoundedRectangle(cornerRadius: 16, style: .continuous), padding: CGFloat = 16, preset: NeumorphicShadowPreset = .standard) -> some View {
        self.padding(padding)
            .background(shape.fill(Color.Neumorphic.main).softOuterShadow(preset))
            .clipShape(shape)
    }
}
