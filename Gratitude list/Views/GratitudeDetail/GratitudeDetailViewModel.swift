//
//  GratitudeDetailViewModel.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 11.03.2024.
//

import Foundation
import SwiftUI

class GratitudeDetailViewModel: ObservableObject {
    private let service: CoreDataGratitudeServiceProtocol
    
    @Published var gratitudeModel: GratitudeDetailModel?
    @Published var selectedImage: Image?
    @Published var toast: Toast? = nil
    @Published var isLoading: Bool = false
    @Published var loadingMessage: String = ""
    @Published var error: Error?

    init(service: CoreDataGratitudeServiceProtocol = CoreDataGratitudeService.shared, gratitudeId: UUID) {
        self.service = service
        
        Task {
            await getGratitude(gratitudeId)
        }
    }
    
    //MARK: Private functions

    @MainActor
    private func getGratitude(_ gratitudeId: UUID) async {
        self.isLoading = true
        self.loadingMessage = "Loading gratitude"
        
        do {
            let gratitudeEntity = try await self.service.getGratitude(withId: gratitudeId)

            gratitudeModel = CoreDataGratitudeMapper.mapGratitudeEntityToGratitudeDetailModel(gratitudeEntity: gratitudeEntity)
            selectedImage = gratitudeModel?.images?.first
            
            self.isLoading = false
        } catch {
            self.error = error
            self.isLoading = false
            self.toast = Toast(style: .error, message: error.localizedDescription)
        }
    }
    
    //MARK: Public functions
    
    @MainActor
    func removeGratitude() async {
        self.isLoading = true
        self.loadingMessage = "Removing gratitude"

        do {
            guard let gratitudeId = gratitudeModel?.id else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not remove"])
                throw error
            }
            try await self.service.removeGratitude(withId: gratitudeId)
            
            self.isLoading = false
        } catch {
            self.error = error
            self.isLoading = false
            self.toast = Toast(style: .error, message: error.localizedDescription)
        }
    }
}
