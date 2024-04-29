//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

protocol SearchViewModel {
	func fetchCity(city: String) async throws -> City
}

class SearchViewModelImpl: SearchViewModel {
	var serviceProvider = ServiceProvider()
	
	func fetchCity(city: String) async throws -> City {
		return try await serviceProvider.serachCityService.getCity(city)
	}
}
