//
//  CoreDataGratitudeService.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 11.03.2024.
//

import Foundation
import CoreData

actor CoreDataGratitudeService: CoreDataGratitudeServiceProtocol {
    static let shared = CoreDataGratitudeService()

    private let container: NSPersistentContainer
    private let containerName = "GratitudeList"
    private let entityName = "GratitudeEntity"
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading core data \(error)")
            }
        }
    }
    
    //MARK: Private functions
    
    private func save() throws {
        do {
            try self.container.viewContext.save()
        } catch {
            throw error
        }
    }
    
    private func removeAll() throws {
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try container.viewContext.execute(batchDeleteRequest)
        } catch {
            throw error
        }
    }
    
    //MARK: Public functions
    
    func getListOfGratitudes() throws -> [GratitudeEntity] {
        let request = NSFetchRequest<GratitudeEntity>(entityName: entityName)
        do {
            return try self.container.viewContext.fetch(request)
        } catch {
            throw error
        }
    }
    
    func getGratitude(withId gratitudeId: UUID) throws -> GratitudeEntity {
        let request = NSFetchRequest<GratitudeEntity>(entityName: entityName)
        request.predicate = NSPredicate(format:"id = %@", gratitudeId as CVarArg)
        
        do {
            let gratitudes = try self.container.viewContext.fetch(request)

            if let gratitude = gratitudes.first {
                return gratitude
            } else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not find gratitude"])
                throw error
            }
        } catch {
            throw error
        }
    }
    
    func addGratitude(with id: UUID, text: String, date: Date, tags: [String]?, images: [Data]?) throws {
        let gratitudeEntity = GratitudeEntity(context: container.viewContext)
        
        gratitudeEntity.id = id
        gratitudeEntity.date = date
        gratitudeEntity.text = text
        gratitudeEntity.tags = tags
        
        do {
            let images = try NSKeyedArchiver.archivedData(withRootObject: images ?? [], requiringSecureCoding: true)
            gratitudeEntity.images = images
            
            try save()
        } catch {
            throw error
        }
    }
    
    func removeGratitude(withId id: UUID) throws {
        let request = NSFetchRequest<GratitudeEntity>(entityName: entityName)
        request.predicate = NSPredicate(format:"id = %@", id as CVarArg)

        do {
            let gratitudes = try self.container.viewContext.fetch(request)

            gratitudes.forEach { gratitude in
                self.container.viewContext.delete(gratitude)
            }

            try save()
        } catch {
            throw error
        }
    }
}
