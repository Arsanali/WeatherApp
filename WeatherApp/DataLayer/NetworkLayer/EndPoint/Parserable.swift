//
//  Parserable.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// Базовый интерфейс парсера данных
protocol Parserable {
	/// Парс полученных данных
	/// - Parameters:
	///   - type: тип данных
	///   - data: данные
	///	  - Returns: результат конкретного парсера
	func parse<T: Codable>(of type: T.Type, from data: Data) -> Result<T, DomainError>
}

