//
//  Typo.swift
//  tmdb-ios
//
//  Created by Wine Chit Paing on 2/2/2568 BE.
//

import SwiftUICore

struct CustomFontModifier: ViewModifier {
    
    var size: CGFloat
    var weight: Font.Weight = .regular

    func body(content: Content) -> some View {
        content
            .font(.custom(weight == .regular ? "Metropolis-Regular" : "Metropolis-SemiBold", size: size))
    }
}

extension View {
    func fontStyle(size: CGFloat,weight: Font.Weight = .regular) -> some View {
        self.modifier(CustomFontModifier(size: size,weight: weight))
    }
}

extension Font {
    
    static let displayLarge = Font.custom("Metropolis-SemiBold", size: 57)
    static let displayMedium = Font.custom("Metropolis-SemiBold", size: 45)
    static let displaySmall = Font.custom("Metropolis-SemiBold", size: 36)

    static let headlineLarge = Font.custom("Metropolis-SemiBold", size: 32)
    static let headlineMedium = Font.custom("Metropolis-SemiBold", size: 28)
    static let headlineSmall = Font.custom("Metropolis-SemiBold", size: 24)

    static let titleLarge = Font.custom("Metropolis-Regular", size: 22)
    static let titleMedium = Font.custom("Metropolis-Regular", size: 16)
    static let titleSmall = Font.custom("Metropolis-Regular", size: 14)

    static let labelLarge = Font.custom("Metropolis-Regular", size: 14)
    static let labelMedium = Font.custom("Metropolis-Regular", size: 12)
    static let labelSmall = Font.custom("Metropolis-Regular", size: 11)

    static let bodyLarge = Font.custom("Metropolis-Regular", size: 16)
    static let bodyMedium = Font.custom("Metropolis-Regular", size: 14)
    static let bodySmall = Font.custom("Metropolis-Regular", size: 12)
}
