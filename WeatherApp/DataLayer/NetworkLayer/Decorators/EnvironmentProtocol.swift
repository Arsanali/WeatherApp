//
//  EnvironmentProtocol.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// Окружение
enum Environment {
	case production
	
	var base: URL {
		switch self {
		case .production:
			guard let base = URL(string: "api.openweathermap.org/data/2.5/") else {
				fatalError("Базовый URL production недействителен")
			}
			return base
		}
	}
	
	var host: String {
		return self.base.host.orEmpty
	}
}

/// Интерфейс сетевого окружения
protocol NetworkEnvironment {
	/// Текущее окружение
	var current: Environment { get }
	
	/// Декораторы запроса
	var decorators: [NetworkDecorator] { get }
}
