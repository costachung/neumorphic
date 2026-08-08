import SwiftUI

/// A linear progress indicator with an inset track.
public struct NeumorphicProgressView: View {
    private let value: Double?
    private let total: Double
    private let tint: Color
    private let height: CGFloat

    public init(value: Double?, total: Double = 1, tint: Color = .accentColor, height: CGFloat = 10) {
        self.value = value
        self.total = max(total, 0)
        self.tint = tint
        self.height = max(height, 2)
    }

    public var body: some View {
        GeometryReader { proxy in
            let fraction = value.map { CGFloat(min(max(total > 0 ? $0 / total : 0, 0), 1)) }
            ZStack(alignment: .leading) {
                Capsule().fill(Color.Neumorphic.main).softInnerShadow(Capsule(), spread: 0.5, radius: 3)
                if let fraction { Capsule().fill(tint).frame(width: proxy.size.width * fraction) }
                else { Capsule().fill(tint).frame(width: proxy.size.width * 0.35).shimmering() }
            }
        }
        .frame(height: height)
    }
}

private extension View {
    @ViewBuilder func shimmering() -> some View {
        #if os(macOS)
        self.opacity(0.7)
        #else
        self.opacity(0.7)
        #endif
    }
}
