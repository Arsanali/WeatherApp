//
//  CoreData.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import CoreData

protocol DataManager {
	func saveDataOf(cities: [City])
	func deleteCity(at indexPath: IndexPath)
	func getNumberOfCities() -> Int
	func getCity(at indexPath: IndexPath) -> CityEntity?
	func setupFetchedResultsController()
	func saveContext()
}

final class DataManagerImp: DataManager {
	
	// MARK: - Core Data stack
	private var fetchedResultsController: NSFetchedResultsController<CityEntity>?
	private var viewContext: NSManagedObjectContext?
	lazy var persistentContainer: NSPersistentContainer = {
		
		let container = NSPersistentContainer(name: "WeatherApp")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()
	
	init() {
		viewContext = persistentContainer.viewContext
		setupFetchedResultsController()
	}
	
	 func setupFetchedResultsController() {
		let request: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(key: #keyPath(CityEntity.name), ascending: false)]
		
		fetchedResultsController = NSFetchedResultsController(
			fetchRequest: request,
			managedObjectContext: persistentContainer.viewContext,
			sectionNameKeyPath: nil,
			cacheName: nil
		)
		
		do {
			try fetchedResultsController?.performFetch()
		} catch {
			print("Failed to initialize FetchedResultsController: \(error)")
		}
	}
		
	func saveContext() {
		let context = persistentContainer.viewContext
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}
	
	func saveDataOf(cities: [City]) {

		for city in cities {
			if !cityExists(name: city.name, in: persistentContainer.viewContext) {
				let cityEntity = CityEntity(context: persistentContainer.viewContext)
				cityEntity.name = city.name
				cityEntity.lat = city.coord?.lat ?? 0.0
				cityEntity.lon = city.coord?.lon ?? 0.0
			}
		}
		
		do {
			try persistentContainer.viewContext.save()
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
		guard let cityEntity = fetchedResultsController?.object(at: indexPath) else { return }
		persistentContainer.viewContext.delete(cityEntity)
		
		do {
			try persistentContainer.viewContext.save()
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
