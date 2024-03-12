//
//  ToastView.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 12.03.2024.
//

import SwiftUI

struct ToastView: View {
    var style: ToastStyle
    var message: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: style.iconFileName)
                .foregroundStyle(style.themeColor)
            Text(message)
                .font(.callout)
                .foregroundStyle(style.themeColor)
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(.black)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .opacity(0.6)
        )
        .padding(.horizontal, 16)
    }
}
