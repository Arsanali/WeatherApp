//
//  ServiceProviderProtocol.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// Интерфес сервиса провайдера
protocol ServiceProviderProtocol: AnyObject {
	var serachCityService: CitySearchServiceProtocol { get }
}
