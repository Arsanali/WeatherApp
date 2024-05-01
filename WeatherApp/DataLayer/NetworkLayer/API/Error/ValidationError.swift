//
//  ValidationError.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// Базовая структура ошибки валидации
struct ValidationError: Error, Codable {
	/// Тип
	let type: String
	
	/// Ошибка
	let error: String
	
	/// Сообщение
	let message: String
}

extension ValidationError: CustomDebugStringConvertible {
	var debugDescription: String {
		return """
  ValidationError {
  type: \(type)
  error: \(error)
  message: \(message)
  }
  """
	}
}


