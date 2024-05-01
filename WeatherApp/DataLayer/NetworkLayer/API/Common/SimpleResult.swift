//
//  SimpleResult.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

struct SimpleResult: Codable {
	/// Ожидается просто "success"
	let result: String
	
	init() {
		result = "success"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		if let result = try container.decodeIfPresent(String.self, forKey: .result) {
			self.result = result
			return
		} else if let errors = try container.decodeIfPresent([ResultError].self, forKey: .errors),
				  let first = errors.first {
			throw first
		}
		throw ResultError.badResponse
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(result, forKey: .result)
	}
}

private extension SimpleResult {
	enum CodingKeys: CodingKey {
		case result, errors
	}
}

extension SimpleResult {
	struct ResultErrorsModel: Codable, Error {
		let errors: [ResultError]
	}
	
	struct ResultError: Codable, Error {
		/// По идее энам ошибок
		let type: String
		
		/// Сообщение
		let message: String
		
		/// Причина
		let reason: String
		
		/// Что вызвало ошибку
		let subject: String?
		
		/// Тип того, что вызвало ошибку
		let subjectType: String?
		
		var localizedDescription: String {
			return message
		}
		
		static var badResponse: Error {
			ResultError(type: "", message: "Не корректный ответ сервера", reason: "badResponse", subject: nil, subjectType: nil)
		}
	}
}


