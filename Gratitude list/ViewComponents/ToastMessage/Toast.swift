//
//  Toast.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 12.03.2024.
//

import Foundation

struct Toast: Equatable {
    var style: ToastStyle
    var message: String
    var duration: Double = 3
    var width: Double = .infinity
}
