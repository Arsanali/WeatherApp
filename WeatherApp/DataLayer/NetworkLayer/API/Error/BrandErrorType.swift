//
//  BrandErrorType.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

// Возможные производные серверной ошибкт
enum BrandErrorType: Error {
	/// Основная серверная ошибка
	case brand(BrandError, Error)
	
	/// Ошибка валидации, приходит при смене окружения
	case validation(ValidationError, Error)
	
	/// Необработанная ошибка хайбриса
	case simpleError(SimpleResult.ResultError, Error)
	
	/// Ошибка парсинга основной модели ошибки
	case parsing(parseError: Error, original: Error)
	
	var responseError: URLResponse.ResponseError? {
		switch self {
		case let .brand(_, error), let .validation(_, error), let .simpleError(_, error):
			return error as? URLResponse.ResponseError
		case let .parsing(parseError: _, original: error):
			return error as? URLResponse.ResponseError
		}
	}
}

// MARK: - Encodable

extension BrandErrorType: Encodable {
	enum CodingKeys: CodingKey {
		case localError
		case originalError
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		
		switch self {
		case let .brand(brandError, underlyingError):
			try container.encode(brandError, forKey: .localError)
			try container.encode(underlyingError.nsDebugDescription, forKey: .originalError)
		case let .validation(validationError, underlyingError):
			try container.encode(validationError, forKey: .localError)
			try container.encode(underlyingError.nsDebugDescription, forKey: .originalError)
		case let .simpleError(simpleError, underlyingError):
			try container.encode(simpleError, forKey: .localError)
			try container.encode(underlyingError.nsDebugDescription, forKey: .originalError)
		case let .parsing(parseError, original: underlyingError):
			try container.encode(parseError.nsDebugDescription, forKey: .localError)
			try container.encode(underlyingError.nsDebugDescription, forKey: .originalError)
		}
	}
}

// MARK: - ErrorDescriptionProtocol

extension BrandErrorType: ErrorDescriptionProtocol {
	var message: String {
		switch self {
		case let .brand(error, _):
			return error.message
		case let .simpleError(error, _):
			return error.message
		case let .validation(error, _):
			return error.message
		case let .parsing(parseError: _, original: error):
			return error.nsDebugDescription
		}
	}
	
	var code: String {
		switch self {
		case let .brand(error, _):
			return error.code
		case let .validation(_, error):
			return String(error.nsError.code)
		case let .simpleError(_, error):
			return String(error.nsError.code)
		case let .parsing(parseError: _, original: error):
			return String(error.nsError.code)
		}
	}
}

// MARK: - CustomDebugStringConvertible

extension BrandErrorType: CustomDebugStringConvertible {
	var debugDescription: String {
		switch self {
		case let .brand(error, _):
			return error.debugDescription
		case let .validation(error, _):
			return error.message
		case let .simpleError(error, _):
			return error.message
		case let .parsing(parseError: parseError, original: originalError):
			return """
   Brand error's parsing error:
   Parsing error:
   \(parseError.nsDebugDescription)
   Original error:
   \(originalError.nsDebugDescription)
   """
		}
	}
}

