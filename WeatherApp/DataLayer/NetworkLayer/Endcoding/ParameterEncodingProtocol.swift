//
//  ParameterEncodingProtocol.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// typealias для входящих параметров
typealias Parameters = [String: Any]

/// Протокол обработки параметров
protocol ParameterEncoder {
	/// Функция обработки входных параметров
	/// - Parameters:
	///   - urlRequest: URL запрос
	///   - parameters: параметры
	func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

/// Протокол-аггрегатор обработки параметров
protocol Encoding {
	/// Функция обработки входных параметров
	/// - Parameters:
	///   - urlRequest: URL запрос
	///   - bodyParameters: параметры тела
	///   - urlParameters: параметры URL
	func encode(urlRequest: inout URLRequest, bodyParameters: Parameters?, urlParameters: Parameters?) throws
}

