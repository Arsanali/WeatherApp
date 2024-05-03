//
//  NetworkDecorator.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// Интерфейс декоратора. Позволяет модифицировать исходный запрос
protocol NetworkDecorator {
	/// Добавляет модификацию к запросу
	/// - Parameter urlRequest: исходный запрос
	func decorate(urlRequest: inout URLRequest)
}
