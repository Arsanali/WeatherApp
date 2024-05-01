//
//  ParameterEncoding.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// Возможные ошибки шифрования
enum ParameterEncodingError: Error {
	
	/// Пустой URL
	case emptyURL
	
	/// Прокси-ошибка обработки JSON'a
	case failureJsonEncode(Error)
}

/// Возможные варианты шифрования
enum ParameterEncoding {
	
	// URL
	case urlEncoding
	
	// Включается в себя urlEncoding и добавляет енкод символа "+"
	case urlPlusEncoding
	
	// URL-подобные параметры в body
	case formDataEncoding
	
	// JSON
	case jsonEncoding
	
	// URL + JSON
	case urlJsonEncoding
}

// MARK: - Encoding

extension ParameterEncoding: Encoding {
	// swiftlint:disable cyclomatic_complexity
	func encode(
		urlRequest: inout URLRequest,
		bodyParameters: Parameters?,
		urlParameters: Parameters?
	) throws {
		do {
			switch self {
			case .urlEncoding:
				guard let urlParameters = urlParameters else { return }
				
				try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
			case .urlPlusEncoding:
				guard let urlParameters = urlParameters else { return }
				
				try URLParameterEncoder(option: .removePlus).encode(urlRequest: &urlRequest, with: urlParameters)
				
			case .formDataEncoding:
				guard let bodyParameters = bodyParameters else { return }
				
				FormDataEncoding().encode(urlRequest: &urlRequest, with: bodyParameters)
				
			case .jsonEncoding:
				guard let bodyParameters = bodyParameters else { return }
				
				try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
				
			case .urlJsonEncoding:
				guard
					let bodyParameters = bodyParameters,
					let urlParameters = urlParameters
				else { return }
				
				try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
				try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
			}
		} catch {
			throw error
		}
	}
}

