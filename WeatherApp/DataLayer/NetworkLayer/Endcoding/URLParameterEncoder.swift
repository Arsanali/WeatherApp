//
//  URLParameterEncoder.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

// Обработчик URL параметров
struct URLParameterEncoder: ParameterEncoder {
	private let option: EncodeOption?
	
	init(option: EncodeOption? = nil) {
		self.option = option
	}
	
	func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
		guard let url = urlRequest.url else { throw ParameterEncodingError.emptyURL }
		
		if
			var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
			!parameters.isEmpty
		{
		urlComponents.queryItems = parameters.map { makeQueryItem(name: $0, value: $1) }
		
		switch option {
		case .removePlus:
			urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.addingPercentEncoding(
				withAllowedCharacters: .urlQueryWithoutPlusAllowed
			)
		case .none:
			break
		}
		
		urlRequest.url = urlComponents.url
		}
		
		urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
	}
}

extension URLParameterEncoder {
	/// Опция для кодирования query-параметров
	enum EncodeOption {
		/// Заменить символ "+"
		case removePlus
	}
}

extension CharacterSet {
	static let urlQueryWithoutPlusAllowed: CharacterSet = {
		var set = CharacterSet.urlQueryAllowed
		set.remove("+")
		return set
	}()
}

private extension URLParameterEncoder {
	func makeQueryItem(name: String, value: Any) -> URLQueryItem {
		return URLQueryItem(name: name, value: "\(value)")
	}
}
