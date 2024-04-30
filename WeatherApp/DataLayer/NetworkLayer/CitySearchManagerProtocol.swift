//
//  NetworkManagerProtocol.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

protocol CitySearchManagerProtocol: AnyObject {
	func getCity(_ city: String) async throws -> City 
	func fetchDetailInfoCity(_ lat: Double, lon: Double) async throws -> DetailCityInfo
}
