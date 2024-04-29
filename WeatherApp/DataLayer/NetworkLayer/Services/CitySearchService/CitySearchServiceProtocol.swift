//
//  SearchCityServiceProtocol.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

protocol CitySearchServiceProtocol {
	func getCity(_ city: String) async throws -> City
}
