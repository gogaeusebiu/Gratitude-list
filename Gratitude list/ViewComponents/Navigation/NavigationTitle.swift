//
//  NavigationTitle.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 11.03.2024.
//

import SwiftUI


struct NavigationTitle: View {
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .truncationMode(.tail)
        }
    }
}

#Preview {
    NavigationTitle(title: "title")
}
