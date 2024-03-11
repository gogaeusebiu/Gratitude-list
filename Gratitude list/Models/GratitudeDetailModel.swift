//
//  GratitudeDetailModel.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 11.03.2024.
//

import Foundation
import SwiftUI

struct GratitudeDetailModel {
    let id: UUID
    let text: String
    let date: Date
    let tags: [String]?
    let images: [Image]?
}
