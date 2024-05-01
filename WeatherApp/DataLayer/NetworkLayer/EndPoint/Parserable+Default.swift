//
//  Parserable+Default.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// Реализация парсера по умолчанию
extension Parserable {
	func parse<T: Decodable>(of type: T.Type, from data: Data) -> Result<T, DomainError> {
		do {
			let response = try JSONDecoder().decode(T.self, from: data)
			return .success(response)
		} catch {
			return .failure(.system(error))
		}
	}
}

extension JSONDecoder: Parserable {
	func parse<T: Decodable>(of type: T.Type, from data: Data) -> Result<T, DomainError> {
		do {
			return .success(try decode(T.self, from: data))
		} catch {
			return .failure(.server(.parsing(parseError: error, original: error)))
		}
	}
}

/// Сущность парсера по умолчанию
struct DefaultParserable: Parserable {}

