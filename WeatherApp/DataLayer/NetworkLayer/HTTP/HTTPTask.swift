//
//  HTTPTask.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// Возможные запросы
enum HTTPTask {
	
	/// Простой запрос
	///   - bodyEncoding: обработчик входящих параметров тела
	///   - urlParameters: параметры URL
	case requestWithoutParameters(
		bodyEncoding: ParameterEncoding,
		urlParameters: Parameters?
	)
	
	/// Запрос с параметрами тела
	///   - bodyParameters: параметры тела
	///   - bodyEncoding: обработчик входящих параметров тела
	///   - urlParameters: параметры URL
	case requestParameters(
		bodyParameters: Parameters?,
		bodyEncoding: ParameterEncoding,
		urlParameters: Parameters?
	)
	
	/// Запрос с контейнером для кодирования параметров с помощью JSONEncoder
	case request(encodeContainer: EncodeContainer)
}

