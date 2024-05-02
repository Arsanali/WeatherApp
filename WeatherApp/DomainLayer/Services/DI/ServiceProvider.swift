//
//  ServiceProvider.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

final class ServiceProvider {
	
	private lazy var userSession = URLSession(
		configuration: .default,
		delegate: nil,
		delegateQueue: nil
	)
	
	private let _environment = EnvironmentService()
	
	private lazy var router = NetworkRouter(
		session: userSession,
		cookieStorage: HTTPCookieStorage.shared,
		errorDecoder: JSONDecoder(),
		environment: _environment
	)
	
	private lazy var networkManager = NetworkManager(session: userSession,
													 router: router,
													 environment: _environment)
}

extension ServiceProvider: ServiceProviderProtocol {
	var dataManager: any DataManager {
		return DataManagerImp()
	}
	
	var searchCityService: any CitySearchServiceProtocol {
		return CitySearchWeatherServiceImp(citySearchManager: networkManager)
	}
}
