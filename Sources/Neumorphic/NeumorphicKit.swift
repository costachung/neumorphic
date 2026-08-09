//
//  Neumorphic.swift
//  Created by Costa Chung on 2/3/2020.
//  Copyright © 2020 Costa Chung. All rights reserved.
//  Neumorphism Soft UI

import Foundation
import SwiftUI

/// Shared color configuration and platform color helpers for Neumorphic.
public struct NeumorphicKit {

    /// Controls whether default Neumorphic colors follow the system appearance.
    public enum ColorSchemeType {
        /// Resolve colors from the current system appearance.
        case auto
        /// Use the light appearance.
        case light
        /// Use the dark appearance.
        case dark
    }

    private final class ColorSchemeStorage: @unchecked Sendable {
        private let lock = NSLock()
        private var value: ColorSchemeType = .auto

        func get() -> ColorSchemeType {
            lock.lock()
            defer { lock.unlock() }
            return value
        }

        func set(_ newValue: ColorSchemeType) {
            lock.lock()
            value = newValue
            lock.unlock()
        }
    }

    private static let colorSchemeStorage = ColorSchemeStorage()

    /// The appearance used when resolving `Color.Neumorphic` colors.
    public static var colorSchemeType: ColorSchemeType {
        get { colorSchemeStorage.get() }
        set { colorSchemeStorage.set(newValue) }
    }

    #if os(macOS)
        /// The native color type used by macOS.
        public typealias ColorType = NSColor
        /// Creates a native platform color from normalized RGB components.
        public static func colorType(red: CGFloat, green: CGFloat, blue: CGFloat) -> ColorType {
            .init(red: red, green: green, blue: blue, alpha: 1.0)
        }
    #else
        /// The native color type used by iOS.
        public typealias ColorType = UIColor
        /// Creates a native platform color from normalized RGB components.
        public static func colorType(red: CGFloat, green: CGFloat, blue: CGFloat) -> ColorType {
            .init(red: red, green: green, blue: blue, alpha: 1.0)
        }
    #endif

    /// Creates a dynamic SwiftUI color from light and dark platform colors.
    public static func color(light: ColorType, dark: ColorType) -> Color {
        #if os(iOS)
            switch NeumorphicKit.colorSchemeType {
            case .light:
                return Color(light)
            case .dark:
                return Color(dark)
            case .auto:
                return Color(.init { $0.userInterfaceStyle == .light ? light : dark })
            }
        #else
            switch NeumorphicKit.colorSchemeType {
            case .light:
                return Color(light)
            case .dark:
                return Color(dark)
            case .auto:
                return Color(
                    .init(
                        name: nil,
                        dynamicProvider: { (appearance) -> NSColor in
                            return appearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua ? dark : light
                        }))
            }
        #endif
    }

}
