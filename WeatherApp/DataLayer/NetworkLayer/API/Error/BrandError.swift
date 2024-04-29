//
//  BrandError.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// Базовая структура ошибки (в будущем)
struct BrandError: Error, Codable {
	enum Code {
		static let emptyCart = "EmptyCartException"
	}
	
	let status: Int
	let time: TimeInterval
	let code: String
	let message: String
}

extension BrandError: CustomDebugStringConvertible {
	var debugDescription: String {
		return """
  BrandError {
   status: \(status)
   time: \(time)
   code: \(code)
   message: \(message)
  }
  """
	}
}

public class DefaultBrandErrors {
	static let tokenDataError = BrandError(
		status: -1,
		time: Date().timeIntervalSince1970,
		code: "140",
		message: "Нет данных для обновления токена"
	)
}


