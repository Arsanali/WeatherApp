//
//  NetworkRouterProtocols.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// Интерфейс, отвечающий за настройку `NetworkRouter`'а
protocol NetworkRouterConfiguratorProtocol: AnyObject {
	/// Отменить все запросы
	func cancelAllRequests()
}

// Интерфейс обращений к серверу
protocol NetworkRouterProtocol: AnyObject {
	@discardableResult
	func performRequestData<T: Endpointable>(
		_ route: T,
		completion: @escaping (Result<Data, DomainError>) -> Void
	) -> SessionTask?
	
	@discardableResult
	func performRequest<T: Endpointable, U: Decodable>(
		_ route: T,
		completion: @escaping (Result<U, DomainError>) -> Void
	) -> SessionTask?
	
	@discardableResult
	func performRequestNoResponse<T: Endpointable>(
		_ route: T,
		completion: @escaping (Result<Void, DomainError>) -> Void
	) -> SessionTask?
	
	@discardableResult
	func produceDataTask<T: Endpointable>(
		with route: T,
		completion: @escaping (Result<Data, DomainError>) -> Void
	) -> SessionTask?
	
	func dataTask(
		with request: URLRequest,
		completion: @escaping (Result<Data, DomainError>) -> Void
	) -> URLSessionDataTask
}

extension DispatchQueue {
	/// Очередь по умолчанию для всех запросов
	static let networkQueue = DispatchQueue(label: "com.azbuka.united.queue.network")
}
