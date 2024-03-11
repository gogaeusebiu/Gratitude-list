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
    
    init(service: CoreDataGratitudeServiceProtocol = CoreDataGratitudeService.shared) {
        self.service = service
    }
    
    @MainActor
    func getListOfGratitudes() async {
        do {
            let gratitudeEntityList = try await service.getListOfGratitudes()
            self.gratitudeList = CoreDataGratitudeMapper.mapGratitudeEntityToGratitudeListModel(gratitudeEntitys: gratitudeEntityList)
        } catch {
            
        }
    }
}
