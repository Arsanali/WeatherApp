//
//  EncodeContainer.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// Обёртка для использования Codable с HTTPTask.
struct EncodeContainer {
	let run: () throws -> Data
	
	init<T: Encodable>(value: T) {
		self.run = { return try JSONEncoder().encode(value) }
	}
}

