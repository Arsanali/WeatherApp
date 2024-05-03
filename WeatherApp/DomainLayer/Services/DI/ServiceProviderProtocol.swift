//
//  ServiceProviderProtocol.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// Интерфес сервиса провайдера
protocol ServiceProviderProtocol: AnyObject {
	///Сервис для работы с сетью
	var searchCityService: CitySearchServiceProtocol { get }
	///Сервис для работы с базой
	var dataManager: DataManager { get }
}
