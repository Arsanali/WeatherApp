//
//  CityEntity+CoreDataProperties.swift
//  WeatherApp
//
//  Created by arslanali on 30.04.2024.
//
//

import Foundation
import CoreData


extension CityEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityEntity> {
        return NSFetchRequest<CityEntity>(entityName: "CityEntity")
    }

    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var name: String?

}

extension CityEntity : Identifiable {

}
