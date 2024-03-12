//
//  ToastStyle.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 12.03.2024.
//

import SwiftUI

enum ToastStyle {
    case error
    case success
    case info
}

extension ToastStyle {
    var themeColor: Color {
        switch self {
        case .error: return .red
        case .info: return .blue
        case .success: return .green
        }
    }
    
    var iconFileName: String {
        switch self {
        case .info: return "info.circle.fill"
        case .success: return "checkmark.circle.fill"
        case .error: return "exclamationmark.triangle"
        }
    }
}
