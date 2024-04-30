//
//  CitySearchService.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

final class CitySearchServiceImp {
	private let citySearchManager: CitySearchManagerProtocol
	
	init(citySearchManager: CitySearchManagerProtocol) {
		self.citySearchManager = citySearchManager
	}
}

extension CitySearchServiceImp: CitySearchServiceProtocol {
	func fetchDetailInfoCity(_ lat: Double, lon: Double) async throws -> DetailCityInfo {
		return try await citySearchManager.fetchDetailInfoCity(lat, lon: lon)
	}
	
	func getCity(_ city: String) async throws -> City {
		return try await citySearchManager.getCity(city)
	}
}
