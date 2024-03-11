//
//  DateView.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 11.03.2024.
//

import SwiftUI

struct DateView: View {
    /// The date to be displayed
    let date: Date
    
    /// Format of the date being displayed
    let dateFormatter: DateFormatter
    
    init(date: Date,
         dateFormatter: DateFormatter = DateFormatter.monthDayYear) {
        self.date = date
        self.dateFormatter = dateFormatter
    }
    
    var body: some View {
        Text(dateFormatter.string(from: date))
            .font(.footnote)
            .foregroundStyle(.gray)
    }
}
