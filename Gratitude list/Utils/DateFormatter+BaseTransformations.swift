//
//  DateFormatter+BaseTransformations.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 11.03.2024.
//

import Foundation

extension DateFormatter {
    
    struct DateConstants {
        static let kMonthDayYearFormat = "MMMM d yyyy"
    }
    
    static let monthDayYear: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = DateConstants.kMonthDayYearFormat
        df.dateStyle = .long
        
        return df
    }()
}
