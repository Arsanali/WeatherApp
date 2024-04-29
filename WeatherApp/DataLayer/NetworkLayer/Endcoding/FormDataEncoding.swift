//
//  FormDataEncoding.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// Обработчик JSON параметров
struct FormDataEncoding: ParameterEncoder {
	func encode(urlRequest: inout URLRequest, with parameters: Parameters) {
		var urlComponents = URLComponents()
		if !parameters.isEmpty {
			urlComponents.queryItems = parameters.map { makeQueryItem(name: $0, value: $1) }
			var body = urlComponents.percentEncodedQueryItems?.reduce(into: "") { $0 += "\($1.name)=\($1.value ?? "")&" }
			body?.removeLast()
			
			urlRequest.httpBody = body?.data(using: .utf8)
		}
		
		if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
			urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
		}
	}
}

private extension FormDataEncoding {
	func makeQueryItem(name: String, value: Any) -> URLQueryItem {
		return URLQueryItem(name: name, value: "\(value)")
	}
}

