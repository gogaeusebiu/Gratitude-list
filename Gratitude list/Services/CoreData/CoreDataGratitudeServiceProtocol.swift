//
//  CoreDataGratitudeServiceProtocol.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 11.03.2024.
//

import Foundation

protocol CoreDataGratitudeServiceProtocol: Actor {
    func getListOfGratitudes() throws -> [GratitudeEntity]
    func getGratitude(withId gratitudeId: UUID) throws -> GratitudeEntity
    func addGratitude(with id: UUID, text: String, date: Date, tags: [String]?, images: [Data]?) throws
    func removeGratitude(withId id: UUID) throws
}
