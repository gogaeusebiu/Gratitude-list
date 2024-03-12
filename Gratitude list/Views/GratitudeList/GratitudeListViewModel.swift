//
//  GratitudeListViewModel.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 11.03.2024.
//

import Foundation

class GratitudeListViewModel: ObservableObject {
    private let service: CoreDataGratitudeServiceProtocol
    
    @Published var gratitudeList = [GratitudeListModel]()
    @Published var toast: Toast? = nil
    @Published var isLoading: Bool = false
    @Published var error: Error?

    init(service: CoreDataGratitudeServiceProtocol = CoreDataGratitudeService.shared) {
        self.service = service
    }
    
    @MainActor
    func getListOfGratitudes() async {
        self.isLoading = true
        do {
            let gratitudeEntityList = try await service.getListOfGratitudes()
            self.gratitudeList = CoreDataGratitudeMapper.mapGratitudeEntityToGratitudeListModel(gratitudeEntitys: gratitudeEntityList)
            
            self.gratitudeList = self.gratitudeList.sorted(by: { $0.date > $1.date })
            
            self.isLoading = false
        } catch {
            self.error = error
            self.isLoading = false
            self.toast = Toast(style: .error, message: error.localizedDescription)
        }
    }
}
