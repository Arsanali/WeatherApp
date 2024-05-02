//
//  DetailCityViewModel.swift
//  WeatherApp
//
//  Created by arslanali on 30.04.2024.
//

import Foundation
import Combine

protocol DetailCityViewModel {
	func fetchDetailInfoCity()
	var listInfo: [ListInfo] { get set }
	var listInfoPublisher: PassthroughSubject<[ListInfo], Never> { get set }
	var cancellables: Set<AnyCancellable> { get set }
}

class DetailCityViewModelImpl: DetailCityViewModel {
	private let serviceProvider: ServiceProviderProtocol
	private let lat: Double
	private let lon: Double
	
	var listInfoPublisher = PassthroughSubject<[ListInfo], Never>()
	var cancellables: Set<AnyCancellable> = []
	var listInfo: [ListInfo] = []
	
	init(serviceProvider: ServiceProviderProtocol, lat: Double, lon: Double) {
		self.serviceProvider = serviceProvider
		self.lat = lat
		self.lon = lon
	}

	@MainActor
	func fetchDetailInfoCity() {
		Task {
			do {
				let data = try await serviceProvider.searchCityService.fetchDetailWeatherCity(lat, lon: lon)
				listInfo = data.list ?? []
				listInfoPublisher.send(listInfo)
			} catch {
				print("Error fetching detail city info: \(error)")
			}
		}
		
	}
}
