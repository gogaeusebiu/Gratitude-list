//
//  GratitudeCard.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 11.03.2024.
//

import SwiftUI

struct GratitudeCard: View {
    // MARK: PROPERTIES
    let gratitude: GratitudeListModel
    
    // MARK: BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            DateView(date: gratitude.date)
            
            Text(gratitude.text)
                .font(.headline)
                .foregroundStyle(.black)
            
            if let image = gratitude.image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: 100)
                    .clipShape(.rect(cornerRadius: 8))
            }
            
            if let tags = gratitude.tags, !tags.isEmpty {
                ListOfTagsComponent(tags: tags)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .clipShape(.rect(cornerRadius: 12))
    }
}

#Preview {
    GratitudeCard(gratitude: GratitudeListModel(id: UUID(), text: "Good day", date: Date.now, tags: ["castig", "loto"], image: nil))
}
