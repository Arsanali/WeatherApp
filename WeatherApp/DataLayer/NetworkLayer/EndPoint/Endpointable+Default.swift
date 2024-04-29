//
//  Endpointable+Default.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// Реализация Endpointable по умолчанию
extension Endpointable {
	var parser: Parserable {
		return DefaultParserable()
	}
	
	func makeRequest(
		with enviroment: NetworkEnvironment,
		cookieStorage: CookieStorage
	) throws -> URLRequest {
		let requestUrl = baseURL ?? enviroment.current.base
		var request = URLRequest(
			url: requestUrl.appendingPathComponent(path),
			cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
			timeoutInterval: timeout
		)
		request.httpMethod = httpMethod.rawValue
		request.addValue(self.headers?.values.first ?? "", forHTTPHeaderField: self.headers?.keys.first ?? "")
		
		switch task {
		case let .requestWithoutParameters(bodyEncoding, urlParameters):
			try bodyEncoding.encode(
				urlRequest: &request,
				bodyParameters: nil,
				urlParameters: urlParameters
			)
		case let .requestParameters(bodyParameters, bodyEncoding, urlParameters):
			try bodyEncoding.encode(
				urlRequest: &request,
				bodyParameters: bodyParameters,
				urlParameters: urlParameters
			)
		case let .request(encodeContainer: container):
			try JSONEncodableParameterEncoder().encode(urlRequest: &request, with: container)
		}
		
		add(
			additionalHeaders: cookieHeaders(for: cookieStorage, baseURL: requestUrl),
			request: &request
		)
		
		enviroment.decorators.forEach { $0.decorate(urlRequest: &request) }
		
		return request
	}
}

private extension Endpointable {
	func cookieHeaders(for cookieStorage: CookieStorage, baseURL: URL?) -> HTTPHeaders? {
		HTTPCookie.requestHeaderFields(
			with: cookieStorage.cookies
				.map { $0.filter { $0.domain == baseURL?.host } }
				.or([])
		)
	}
	
	func add(additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
		additionalHeaders?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
	}
}

