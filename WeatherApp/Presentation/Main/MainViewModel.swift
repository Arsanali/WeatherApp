//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation
import CoreData
import UIKit

protocol MainViewModel {
	func numberOfRowsInSection (section: Int) -> Int
	func deleteCity(indexPath: IndexPath)
	func object (indexPath: IndexPath) -> CityEntity?
	func didSelectCity(lat: Double, lon: Double)
	var delegate: UpdateTableViewDelegate? { get set }
}

protocol UpdateTableViewDelegate: NSObjectProtocol {
	func reloadData(sender: MainViewModel)
}

final class MainViewModelImlp: MainViewModel {
	var serviceProvider: ServiceProviderProtocol
	var router: MainRouterInput? 
	weak var delegate: UpdateTableViewDelegate?
	
	init(serviceProvider: ServiceProviderProtocol) {
		self.serviceProvider = serviceProvider
	}

	func numberOfRowsInSection(section: Int) -> Int {
		serviceProvider.dataManager.getNumberOfCities()
	}
	
	func deleteCity(indexPath: IndexPath) {
		serviceProvider.dataManager.deleteCity(at: indexPath)
	}
	
	func object(indexPath: IndexPath) -> CityEntity? {
		serviceProvider.dataManager.getCity(at: indexPath)
	}
	
	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		self.delegate?.reloadData(sender: self)
	}
	
	func didSelectCity(lat: Double, lon: Double) {
		guard let router = router else { return }
		router.openDetailView(lat: lat, lon: lon)
	}
}
