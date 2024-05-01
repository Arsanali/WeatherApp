//
//  CoreData.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import UIKit
import CoreData

protocol DataManager {
	func saveDataOf(cities: [City])
}

final class DataManagerImp: DataManager {

	private let container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
	
	private let fetchRequest = NSFetchRequest<CityEntity>(entityName: "CityEntity")
	
	func saveDataOf(cities: [City]) {
		self.container?.performBackgroundTask { [weak self] context in
			var notificationSent = false
			for city in cities {
				
				if !(self?.cityExists(name: city.name , in: context) ?? true) {
					let cityEntity = CityEntity(context: context)
					cityEntity.name = city.name
					cityEntity.lat = city.coord?.lat ?? 0.0
					cityEntity.lon = city.coord?.lon ?? 0.0
					
					do {
						try context.save()
						notificationSent = true
					} catch {
						print("Failed to save context: \(error)")
					}
				}
			}
			if notificationSent {
				NotificationCenter.default.post(name: Notification.Name("SearchViewModelCityUpdated"), object: nil)
			}
		}
	}
	
	private func cityExists(name: String, in context: NSManagedObjectContext) -> Bool {
		let fetchRequest: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "name == %@", name)
		
		do {
			let count = try context.count(for: fetchRequest)
			return count > 0
		} catch {
			print("Error fetching city: \(error)")
			return false
		}
	}
}
