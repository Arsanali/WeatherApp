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
	func deleteCity(at indexPath: IndexPath)
	func getNumberOfCities() -> Int
	func getCity(at indexPath: IndexPath) -> CityEntity?
	func setupFetchedResultsController()
}

final class DataManagerImp: DataManager {
	
	private var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
	private var fetchedResultsController: NSFetchedResultsController<CityEntity>?
	private var viewContext: NSManagedObjectContext?
	
	init() {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			fatalError("AppDelegate is not found")
		}
		container = appDelegate.persistentContainer
		viewContext = container?.viewContext
		setupFetchedResultsController()
	}
	
	 func setupFetchedResultsController() {
		guard let viewContext = viewContext else {
			print("Error: viewContext is nil.")
			return
		}
		
		let request: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(key: #keyPath(CityEntity.name), ascending: false)]
		
		fetchedResultsController = NSFetchedResultsController(
			fetchRequest: request,
			managedObjectContext: viewContext,
			sectionNameKeyPath: nil,
			cacheName: nil
		)
		
		do {
			try fetchedResultsController?.performFetch()
		} catch {
			print("Failed to initialize FetchedResultsController: \(error)")
		}
	}
	
	func saveDataOf(cities: [City]) {
		guard let viewContext = viewContext else {
			print("Error: viewContext is nil.")
			return
		}
		
		for city in cities {
			if !cityExists(name: city.name, in: viewContext) {
				let cityEntity = CityEntity(context: viewContext)
				cityEntity.name = city.name
				cityEntity.lat = city.coord?.lat ?? 0.0
				cityEntity.lon = city.coord?.lon ?? 0.0
			}
		}
		
		do {
			try viewContext.save()
			NotificationCenter.default.post(name: Notification.Name("SearchViewModelCityUpdated"), object: nil)
		} catch {
			print("Failed to save context: \(error)")
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
	
	func deleteCity(at indexPath: IndexPath) {
		guard let cityEntity = fetchedResultsController?.object(at: indexPath), let viewContext = viewContext else { return }
		viewContext.delete(cityEntity)
		
		do {
			try viewContext.save()
		} catch {
			print("Failed to save context after deletion: \(error)")
		}
	}
	
	func getNumberOfCities() -> Int {
		return fetchedResultsController?.sections?[0].numberOfObjects ?? 0
	}
	
	func getCity(at indexPath: IndexPath) -> CityEntity? {
		return fetchedResultsController?.object(at: indexPath)
	}
}
