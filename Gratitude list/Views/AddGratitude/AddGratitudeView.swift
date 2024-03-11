//
//  AddGratitudeView.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 11.03.2024.
//

import SwiftUI
import PhotosUI

struct AddGratitudeView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: AddGratitudeViewModel

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                TextFieldComponent(placeholder: "Enter gratitude description",
                                   text: $viewModel.gratitudeDescription,
                                   errorText: $viewModel.inlineGratitudeDescriptiontError,
                                   logoImageName: "pencil.and.scribble",
                                   label: "Gratitude description")
                .onEndEditing {
                    viewModel.startValidateGratitudeDescription()
                }
                
                TextFieldComponent(placeholder: "Enter hashtag",
                                   text: $viewModel.hashtag,
                                   logoImageName: "number",
                                   label: "Hashtags")
                .onSubmit {
                    viewModel.saveHashtag()
                }
                
                ListOfTagsComponent(tags: viewModel.hashtags)
                
                ListOfImages(images: viewModel.selectedImages)
                
                PhotosPicker("Select photos", selection: $viewModel.photoPickerItems, matching: .images)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 0)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56, alignment: .center)
                    .background(.cyan)
                    .cornerRadius(8)
                
                Button {
                    Task {
                        await viewModel.addGratitude()
                        router.popToRoot()
                    }
                } label: {
                    HStack(alignment: .center, spacing: 10) {
                        Text("Save gratitude")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 0)
                    .frame(height: 56, alignment: .center)
                    .background(!viewModel.gratitudeDescription.isEmpty ? .cyan : Color(red: 0.75, green: 0.75, blue: 0.75))
                    .cornerRadius(8)
                }
                .disabled(viewModel.gratitudeDescription.isEmpty)

            }
            .padding(20)
            .onChange(of: viewModel.photoPickerItems) { oldValue, newValue in
                Task {
                    viewModel.selectedImages.removeAll()
                    
                    for item in viewModel.photoPickerItems {
                        if let image = try? await item.loadTransferable(type: Image.self) {
                            viewModel.selectedImages.append(image)
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationBackButton()
            }
            ToolbarItem(placement: .topBarLeading) {
                NavigationTitle(title: "Add Gratitude")
            }
        }
    }
}
