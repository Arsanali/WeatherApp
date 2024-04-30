//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by arslanali on 28.04.2024.
//

import Foundation

class NetworkManager {
	
	// MARK: - Properties
	private let environment: NetworkEnvironment
	private let operationsManagingQueue = DispatchQueue.global()
	private let responseProcessingLock = NSLock()
	private let refreshLimit = 3
	private let session: URLSession
	private let router: NetworkRouterProtocol
	
	// MARK: - Init
	
	init(
		session: URLSession,
		router: NetworkRouterProtocol,
		environment: NetworkEnvironment
	) {
		self.session = session
		self.router = router
		self.environment = environment
	}
	
	deinit {
		session.invalidateAndCancel()
	}
}

// MARK: - Private
private extension NetworkManager {
	
	@discardableResult
	func performRequest<T: Endpointable, U: Decodable>(
		_ route: T,
		responseOn queue: DispatchQueue = .main,
		completion: @escaping (Result<U, DomainError>) -> Void
	) -> SessionTask? {
		return self.router.performRequest(route, completion: completion)
	}
}

extension NetworkManager: CitySearchManagerProtocol {
	func fetchDetailInfoCity(_ lat: Double, lon: Double) async throws -> DetailCityInfo {
		return try await withCheckedThrowingContinuation { continuation in
			performRequest(CityEndPoint.detailInfoCity(lat: lat, lon: lon)) { (result: Result<DetailCityInfo, DomainError>) in
				switch result {
				case .success(let city):
					continuation.resume(returning: city)
				case .failure(let error):
					continuation.resume(throwing: error)
				}
			}
		}
	}
	
	func getCity(_ city: String) async throws -> City {
		return try await withCheckedThrowingContinuation { continuation in
			performRequest(CityEndPoint.searchCity(city: city)) { (result: Result<City, DomainError>) in
				switch result {
				case .success(let city):
					continuation.resume(returning: city)
				case .failure(let error):
					continuation.resume(throwing: error)
				}
			}
		}
	}
}
