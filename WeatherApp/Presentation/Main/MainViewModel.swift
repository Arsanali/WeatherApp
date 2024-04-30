//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation
import Combine
import CoreData
import UIKit

protocol MainViewModel {
	
}

protocol UpdateTableViewDelegate: NSObjectProtocol {
	func reloadData(sender: MainViewModelImlp)
}


final class MainViewModelImlp: NSObject, NSFetchedResultsControllerDelegate, MainViewModel {
	
	private let container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
	private var fetchedResultsController: NSFetchedResultsController<CityEntity>?
	weak var delegate: UpdateTableViewDelegate?
	
	
	//MARK: - Fetched Results Controller - Retrieve data from Core Data
	func retrieveDataFromCoreData() {
		do {
			guard let context = self.container?.viewContext else {
				print("Error: NSPersistentContainer or viewContext is nil.")
				return
			}
			
			let request: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
			request.sortDescriptors = [NSSortDescriptor(key: #keyPath(CityEntity.name), ascending: false)]
			
			self.fetchedResultsController = NSFetchedResultsController(
				fetchRequest: request,
				managedObjectContext: context,
				sectionNameKeyPath: nil,
				cacheName: nil
			)
			
			fetchedResultsController?.delegate = self
			try fetchedResultsController?.performFetch()
		} catch {
			print("Failed to initialize FetchedResultsController: \(error)")
		}
		
	}
	
	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		// Update the tableView
		self.delegate?.reloadData(sender: self)
	}
	
	//MARK: - TableView DataSource functions
	func numberOfRowsInSection (section: Int) -> Int {
		return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
	}
	
	func object (indexPath: IndexPath) -> CityEntity? {
		return fetchedResultsController?.object(at: indexPath)
	}
	
	func deleteCity(indexPath: IndexPath) {
		// Получаем объект CityEntity, который нужно удалить
		guard let cityEntity = fetchedResultsController?.object(at: indexPath) else { return }
		
		// Удаляем объект из Core Data
		if let context = cityEntity.managedObjectContext {
			context.delete(cityEntity)
			
			do {
				try context.save()
			} catch {
				print("Failed to save context after deletion: \(error)")
			}
		}
	}
}
