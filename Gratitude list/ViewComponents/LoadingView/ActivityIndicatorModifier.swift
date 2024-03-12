//
//  ActivityIndicatorModifier.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 12.03.2024.
//

import SwiftUI

struct ActivityIndicatorModifier: AnimatableModifier {
    var isLoading: Bool
    var message: String
    var color: Color

    init(isLoading: Bool,
         message: String = "Now Loading",
         color: Color = .primary) {
        
        self.isLoading = isLoading
        self.message = message
        self.color = color
    }

    func body(content: Content) -> some View {
        ZStack {
            if isLoading {
                GeometryReader { geometry in
                    ZStack(alignment: .center) {
                        content
                            .disabled(isLoading)
                            .blur(radius: isLoading ? 3 : 0)

                        VStack {
                            Text(message)
                            ActivityIndicator(isAnimating: .constant(true), style: .large)
                        }
                        .frame(width: geometry.size.width / 2,
                               height: geometry.size.height / 5)
                        .background(Color.secondary.colorInvert())
                        .foregroundColor(color)
                        .cornerRadius(20)
                        .opacity(self.isLoading ? 1 : 0)
                        .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
                    }
                }
            } else {
                content
            }
        }
    }
}
