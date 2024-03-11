//
//  ListOfTagsComponent.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 11.03.2024.
//

import SwiftUI

struct ListOfTagsComponent: View {
    /// List of tags
    let tags: [String]
    
    init(tags: [String]) {
        self.tags = tags
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(tags, id: \.self) { tag in
                    HStack(alignment: .center, spacing: 6) {
                        Text("#\(tag)")
                            .font(.footnote)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .cornerRadius(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .inset(by: 0.5)
                            .stroke(.gray, lineWidth: 1)
                    )
                }
            }
        }
    }
}
