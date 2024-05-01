//
//  URLResponse+Extension.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

extension URLResponse {
	static let brokenStatusCode: Int = 9999
	
	enum ResponseError: Error, Equatable {
		case auth
		case tokenExpired
		case refreshTokenExpired
		case refreshAPIFailed
		case alco
		case server
		case unknown
		case brokenStatusCode
		case notFound
		case notAcceptable
		case special
	}
	
	/// Код ответа
	var castStatusCode: Int {
		guard let statusCode: Int = (self as? HTTPURLResponse)?.statusCode else {
			return URLResponse.brokenStatusCode
		}
		return statusCode
	}
}
