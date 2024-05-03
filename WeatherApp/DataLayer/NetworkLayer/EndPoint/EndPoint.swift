//
//  EndPoint.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// Базовый интерфейс эндпоинта
protocol Endpoint {
	/// Базовый урл эндпоинта, используется для сторонних апи которых нет в окружении
	/// - Note: По умолчанию `nil`
	var baseURL: URL? { get }
	
	/// Метод запроса
	var path: String { get }
	
	/// Тип запроса
	var httpMethod: HTTPMethod { get }
	
	/// Тело запроса
	var task: HTTPTask { get }
	
	/// Хедеры запроса
	/// - Note: По умолчанию `nil`
	var headers: HTTPHeaders? { get }
	
	/// Таймаут ответа
	/// - Note: По умолчанию 30
	var timeout: TimeInterval { get }
}

extension Endpoint {
	var headers: HTTPHeaders? { nil }
	var baseURL: URL? { nil }
	var timeout: TimeInterval { 30 }
}

