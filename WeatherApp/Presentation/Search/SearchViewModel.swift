//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

protocol SearchViewModel {
	func fetchCity(city: String) async throws -> City
	func saveData(cities: [City])
}

class SearchViewModelImpl: SearchViewModel {
	
	let serviceProvider: ServiceProviderProtocol
	
	init(serviceProvider: ServiceProviderProtocol) {
		self.serviceProvider = serviceProvider
	}
	
	func fetchCity(city: String) async throws -> City {
		return try await serviceProvider.serachCityService.getCity(city)
	}
	
	func saveData(cities: [City]) {
		serviceProvider.dataManager.saveDataOf(cities: cities)
	}
}
