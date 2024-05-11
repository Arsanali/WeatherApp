//
//  NetworkRouter.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation
import OSLog

typealias SessionTask = CancellableTask & ResumebleTask

final class NetworkRouter: NetworkRouterProtocol {
	
	//MARK: - private properties
	private let session: URLSession
	private let cookieStorage: CookieStorage
	private let errorDecoder: JSONDecoder
	private let environment: NetworkEnvironment
	
	init(
		session: URLSession,
		cookieStorage: CookieStorage,
		errorDecoder: JSONDecoder,
		environment: NetworkEnvironment
	) {
		session.configuration.waitsForConnectivity = true
		self.session = session
		self.cookieStorage = cookieStorage
		self.errorDecoder = errorDecoder
		self.environment = environment
	}
	
	@discardableResult
	func performRequestData<T: Endpointable>(
		_ route: T,
		completion: @escaping (Result<Data, DomainError>) -> Void
	) -> SessionTask? {
		produceDataTask(with: route) { responseResult in
			completion(responseResult.flatMap { .success($0) })
		}
	}
	
	@discardableResult
	func performRequest<T: Endpointable, U: Decodable>(
		_ route: T,
		completion: @escaping (Result<U, DomainError>) -> Void
	) -> SessionTask? {
		produceDataTask(with: route) { responseResult in
			completion(responseResult.flatMap { route.parser.parse(of: U.self, from: $0) })
		}
	}
	
	@discardableResult
	func performRequestNoResponse<T: Endpointable>(
		_ route: T,
		completion: @escaping (Result<Void, DomainError>) -> Void
	) -> SessionTask? {
		produceDataTask(with: route) { responseResult in
			completion(responseResult.flatMap { _ in .success(Void()) })
		}
	}
	
	@discardableResult
	func produceDataTask<T: Endpointable>(
		with route: T,
		completion: @escaping (Result<Data, DomainError>) -> Void
	) -> SessionTask? {
		do {
			let  request = try route.makeRequest(with: environment, cookieStorage: cookieStorage)
			return dataTask(with: request, completion: completion)
		} catch(let error) {
			print("Не удалось создать Request \(error.localizedDescription)")
			return nil
		}
	}
	
	func dataTask(
		with request: URLRequest,
		completion: @escaping (Result<Data, DomainError>) -> Void
	) -> URLSessionDataTask {
		
		let task = session.dataTask(with: request) { [weak self] data, response, error in
#if DEBUG
			if true {
				let httpResponse = response as? HTTPURLResponse
				os_log(.debug, "Response from %@\n\tHeaders: %@\n\tBody: %@\n",
					   request.url?.absoluteString ?? "(nil)",
					   httpResponse.flatMap{ $0.allHeaderFields as? [String:String] }
					.flatMap{ $0.map{ "\($0.key): \($0.value)" }.joined(separator: "\n\t\t") }
					   ?? "(nil)",
					   data.flatMap{ String(data: $0, encoding: .utf8) } ?? "(nil)"
				)
			}
#endif
			if let error = error {
				return completion(.failure(.system(error)))
			}
			
			guard let response = response, let data = data else {
				let error = URLError(.badServerResponse)
				return completion(.failure(.system(error)))
			}
			
			let result: DomainError
			do {
				if let brandError = try? self?.errorDecoder.decode(BrandError.self, from: data) {
					guard let error = self?.handleNetworkResponse(response, gatewayCode: brandError.code) else {
						return completion(.success(data))
					}
					result = .server(.brand(brandError, error))
				} else if
					let model = try? self?.errorDecoder.decode(SimpleResult.ResultErrorsModel.self, from: data),
					let simpleError = model.errors.first
				{
				guard let error = self?.handleNetworkResponse(response) else {
					return completion(.success(data))
				}
				result = .server(.simpleError(simpleError, error))
				} else {
					guard
						let error = self?.handleNetworkResponse(response),
						let validationError = try self?.errorDecoder.decode(ValidationError.self, from: data)
					else {
						return completion(.success(data))
					}
					result = .server(.validation(validationError, error))
				}
			} catch let parseError {
				guard let error = self?.handleNetworkResponse(response) else {
					return completion(.success(data))
				}
				result = .server(.parsing(parseError: parseError, original: error))
			}
			
			completion(.failure(result))
			
		}
		task.resume()
		return task
	}
}

// MARK: - Helpers

private extension NetworkRouter {
	// swiftlint:disable cyclomatic_complexity
	func handleNetworkResponse(_ response: URLResponse, gatewayCode: String? = nil) -> Error? {
		switch response.castStatusCode {
		case 200...299: return nil
		case 400: return URLResponse.ResponseError.server
		case 401 where gatewayCode.orEmpty.hasSuffix("000012"): return URLResponse.ResponseError.tokenExpired
		case 401 where gatewayCode.orEmpty.hasSuffix("000148"): return URLResponse.ResponseError.refreshTokenExpired
		case 401 where gatewayCode.orEmpty.hasSuffix("000149"): return URLResponse.ResponseError.refreshAPIFailed
		case 401 where gatewayCode == nil: return URLResponse.ResponseError.unknown
		case 401: return URLResponse.ResponseError.refreshTokenExpired
		case 404: return URLResponse.ResponseError.notFound
		case 406: return URLResponse.ResponseError.notAcceptable
		case 412: return URLResponse.ResponseError.alco
		case 402..<500: return URLResponse.ResponseError.auth
		case 503: return URLResponse.ResponseError.special
		case 500..<600: return URLResponse.ResponseError.server
		case URLResponse.brokenStatusCode: return URLResponse.ResponseError.brokenStatusCode
		default: return URLResponse.ResponseError.unknown
		}
	}
	// swiftlint:enable cyclomatic_complexity
}

// MARK: - Inner types

extension NetworkRouter {
	struct ConfigurationError: Error {}
}
