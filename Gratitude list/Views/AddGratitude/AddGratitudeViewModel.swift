//
//  AddGratitudeViewModel.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 11.03.2024.
//

import Combine
import Foundation
import PhotosUI
import SwiftUI

class AddGratitudeViewModel: ObservableObject {
    private let service: CoreDataGratitudeServiceProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var toast: Toast? = nil
    @Published var isLoading: Bool = false
    @Published var error: Error?

    @Published var gratitudeDescription = ""
    @Published var inlineGratitudeDescriptiontError = ""
    
    @Published var hashtag = ""
    @Published var inlineHashtagError = ""
    @Published var hashtags = [String]()
    
    @Published var photoPickerItems = [PhotosPickerItem]()
    @Published var selectedImages = [Image]()
    
    init(service: CoreDataGratitudeServiceProtocol = CoreDataGratitudeService.shared) {
        self.service = service
    }
    
    //MARK: Private validators
    
    var isGratitudeDescriptionValid: AnyPublisher<Bool, Never> {
        $gratitudeDescription
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .map { return !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    //MARK: Public functions
    
    @MainActor
    func addGratitude() async {
        self.isLoading = true

        do {
            var imageDataArray = [Data]()
            for item in photoPickerItems {
                if let image = try? await item.loadTransferable(type: Data.self) {
                    imageDataArray.append(image)
                }
            }
            
            try await service.addGratitude(with: UUID(), text: gratitudeDescription, date: Date.now, tags: hashtags, images: imageDataArray)
            
            self.isLoading = false
        } catch {
            self.error = error
            self.isLoading = false
            self.toast = Toast(style: .error, message: error.localizedDescription)
        }
    }
    
    func startValidateGratitudeDescription() {
        isGratitudeDescriptionValid
            .receive(on: RunLoop.main)
            .map {
                if !$0 {
                    return "You have to write a description."
                }
                return ""
            }
            .assign(to: \.inlineGratitudeDescriptiontError, on: self)
            .store(in: &cancellables)
    }
    
    func saveHashtag() {
        if !hashtag.isEmpty {
            hashtags.append(hashtag)
            hashtag = ""
        }
    }
}
