//
//  NavigationBackButton.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 11.03.2024.
//

import SwiftUI

struct NavigationBackButton: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.backward")
        }
    }
}
