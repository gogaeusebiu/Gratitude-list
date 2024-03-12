//
//  View+ToastModifier.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 12.03.2024.
//

import SwiftUI

extension View {
    func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
}
