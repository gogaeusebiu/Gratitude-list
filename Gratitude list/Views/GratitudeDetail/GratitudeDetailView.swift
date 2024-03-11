//
//  GratitudeDetailView.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 11.03.2024.
//

import SwiftUI

struct GratitudeDetailView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: GratitudeDetailViewModel

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                DateView(date: viewModel.gratitudeModel?.date ?? Date.now)
                
                Text(viewModel.gratitudeModel?.text ?? "")
                    .font(.headline)
                    .foregroundStyle(.black)
                
                if let image = viewModel.selectedImage {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .frame(maxWidth: .infinity)
                        .contentShape(Rectangle())
                        .clipShape(.rect(cornerRadius: 8))
                }
                
                if let images = viewModel.gratitudeModel?.images {
                    ListOfImages(images: images, selectedImage: $viewModel.selectedImage)
                }
                
                if let tags = viewModel.gratitudeModel?.tags, !tags.isEmpty {
                    ListOfTagsComponent(tags: tags)
                }
            }
            .padding(20)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationBackButton()
            }
            ToolbarItem(placement: .topBarTrailing) {
                NavigationImageButton(systemName: "trash")
                    .tapAction {
                        Task {
                            await viewModel.removeGratitude()
                            router.popToRoot()
                        }
                    }
            }
        }
    }
}
