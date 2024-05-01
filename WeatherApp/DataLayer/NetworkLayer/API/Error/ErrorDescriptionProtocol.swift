//
//  ErrorDescriptionProtocol.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// Позволяет получать описание ошибки, доступное пользователю
protocol ErrorDescriptionProtocol {
	/// Текст ошибки
	var message: String { get }
	
	/// Уникальный код ошибки
	var code: String { get }
}
