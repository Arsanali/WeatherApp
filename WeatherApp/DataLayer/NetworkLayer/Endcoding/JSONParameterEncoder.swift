//
//  JSONParameterEncoder.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// Обработчик JSON параметров
struct JSONParameterEncoder: ParameterEncoder {
	func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
		do {
			urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
			urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
		} catch {
			throw ParameterEncodingError.failureJsonEncode(error)
		}
	}
}

