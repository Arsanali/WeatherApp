//
//  Endpointable.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// Интерфейс-аггрегатор для эндпоинта
protocol Endpointable: Endpoint {
	/// Создание запроса по параметрам
	/// - Parameters:
	///   - enviroment: сетевое окружение
	///   - cookieStorage: коробочка с печеньками :З
	func makeRequest(
		with enviroment: NetworkEnvironment,
		cookieStorage: CookieStorage
	) throws -> URLRequest
	
	/// Парсер
	var parser: Parserable { get }
}


