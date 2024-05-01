//
//  DomainError.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// Варианты ошибок в приложении
enum DomainError: Error {
	/// Ошибка сервера или её производные
	case server(BrandErrorType)
	
	/// Системная ошибка
	case system(Error)
	
	/// Специфическая ошибка
	case custom(Error)
	
	/// Является ли ошибка ошибкой сервера
	var isServerError: Bool {
		if case .server = self {
			return true
		} else {
			return false
		}
	}
}

// MARK: - Encodable

extension DomainError: Encodable {
	func encode(to encoder: Encoder) throws {
		var container = encoder.unkeyedContainer()
		
		switch self {
		case let .server(brandError):
			try container.encode(brandError)
		case let .system(error), let .custom(error):
			try container.encode(error.nsDebugDescription)
		}
	}
}

// MARK: - ErrorDescriptionProtocol

extension DomainError: ErrorDescriptionProtocol {
	var message: String {
		switch self {
		case let .server(error):
			return error.message
		case let .custom(error as ErrorDescriptionProtocol):
			return error.message
		case let .system(error), let .custom(error):
			return error.localizedDescription
		}
	}
	
	var code: String {
		switch self {
		case let .server(error):
			return error.code
		case let .custom(error as ErrorDescriptionProtocol):
			return error.code
		case let .system(error), let .custom(error):
			return String(error.nsError.code)
		}
	}
}

// MARK: - ErrorDescriptionProtocol

extension DomainError: CustomDebugStringConvertible {
	var debugDescription: String {
		switch self {
		case let .server(error):
			return error.debugDescription
		case let .system(error), let .custom(error):
			return error.nsDebugDescription
		}
	}
}
