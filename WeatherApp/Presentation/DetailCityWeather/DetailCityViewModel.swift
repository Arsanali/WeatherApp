//
//  DetailCityViewModel.swift
//  WeatherApp
//
//  Created by arslanali on 30.04.2024.
//

import Foundation

protocol DetailCityViewModel {
	func fetchDetailInfoCity(_ lat: Double, _ lon: Double) async throws -> DetailCityInfo
}

class DetailCityViewModelImpl: DetailCityViewModel {
	var serviceProvider = ServiceProvider()
	
	func fetchDetailInfoCity(_ lat: Double, _ lon: Double) async throws -> DetailCityInfo {
		return try await serviceProvider.serachCityService.fetchDetailWeatherCity(lat, lon: lon)
	}
}
