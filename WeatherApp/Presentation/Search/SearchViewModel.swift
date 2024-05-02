//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation
import Combine

protocol SearchViewModel {
	var cancellables: Set<AnyCancellable> { get set }
	var cityModel: [City] { get set }
	var cityModelPublisher: PassthroughSubject<[City], Never> { get set }
	func saveData(cities: [City])
	func searchSity(_ city: String)
	
}

class SearchViewModelImpl: SearchViewModel {
	
	let serviceProvider: ServiceProviderProtocol
	var cityModel: [City] = []
	var cityModelPublisher = PassthroughSubject<[City], Never>()
	var cancellables: Set<AnyCancellable> = []
	
	init(serviceProvider: ServiceProviderProtocol) {
		self.serviceProvider = serviceProvider
	}
	@MainActor
	func searchSity(_ city: String) {
		Task {
			do {
				let model = try await serviceProvider.searchCityService.getCity(city)
				cityModel.append(model)
				cityModelPublisher.send([model])
				self.saveData(cities: [model])
			}
		}
	}
	
	func saveData(cities: [City]) {
		serviceProvider.dataManager.saveDataOf(cities: cities)
	}
}
