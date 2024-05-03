//
//  JSONEncodableParameteEncoder.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// Формирует тело запроса с помощью Encodable
struct JSONEncodableParameterEncoder {
	func encode(urlRequest: inout URLRequest, with container: EncodeContainer) throws {
		do {
			urlRequest.httpBody = try container.run()
			
			if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
				urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
			}
		} catch {
			throw ParameterEncodingError.failureJsonEncode(error)
		}
	}
}

