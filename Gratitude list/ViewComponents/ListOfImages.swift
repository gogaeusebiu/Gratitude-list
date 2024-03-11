//
//  ListOfImages.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 11.03.2024.
//

import SwiftUI

struct ListOfImages: View {
    
    /// List of images to be shown in a horizontal list
    let images: [Image]
    
    /// Selected photo from the array
    var selectedImage: Binding<Image?>?
    
    init(images: [Image], selectedImage: Binding<Image?>? = nil) {
        self.images = images
        self.selectedImage = selectedImage
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(0..<images.count, id: \.self) { index in
                    VStack {
                        images[index]
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                    }
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.1))
                    .cornerRadius(8)
                    .onTapGesture {
                        selectedImage?.wrappedValue = images[index]
                    }
                }
            }
        }
    }
}
