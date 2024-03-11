//
//  CoreDataGratitudeMapper.swift
//  Gratitude list
//
//  Created by Goga Eusebiu on 11.03.2024.
//

import Foundation
import SwiftUI

struct CoreDataGratitudeMapper {
    static func mapGratitudeEntityToGratitudeListModel(gratitudeEntitys: [GratitudeEntity]) -> [GratitudeListModel] {
        return gratitudeEntitys.map { gratitude in GratitudeListModel(id: gratitude.id ?? UUID(),
                                                                      text: gratitude.text ?? "",
                                                                      date: gratitude.date ?? Date.now,
                                                                      tags: gratitude.tags,
                                                                      image: mapImagesDataToUIImage(images: gratitude.images).first)
        }
    }
    
    static func mapGratitudeEntityToGratitudeDetailModel(gratitudeEntity: GratitudeEntity) -> GratitudeDetailModel {
        return GratitudeDetailModel(id: gratitudeEntity.id ?? UUID(),
                                    text: gratitudeEntity.text ?? "",
                                    date: gratitudeEntity.date ?? Date.now,
                                    tags: gratitudeEntity.tags,
                                    images: mapImagesDataToUIImage(images: gratitudeEntity.images))
    }
    
    static func mapImagesDataToUIImage(images: Data?) -> [Image] {
        guard let images = images else { return [] }
        do {
            let dataArray = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, NSString.self, NSData.self], from: images) as! [Data]
            
            return dataArray.map { imageData in
               Image(uiImage: UIImage(data: imageData)!)
            }
        } catch {
            print("could not unarchive array: \(error)")
        }
        
        return []
    }
}
