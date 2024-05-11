//
//  CitySearchService.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

final class CitySearchWeatherServiceImp {
	private let manager: CitySearchWeatherManager
	
	init(manager: CitySearchWeatherManager) {
		self.manager = manager
	}
}

extension CitySearchWeatherServiceImp: CitySearchServiceProtocol {
	func fetchDetailWeatherCity(_ lat: Double, lon: Double) async throws -> DetailCityInfo {
		return try await manager.fetchDetailInfoCity(lat, lon: lon)
	}
	
	func getCity(_ city: String) async throws -> City {
		return try await manager.getCity(city)
	}
}
