//
//  Error+Utils.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

extension Error {
	/// Та же ошибка только с типом NSError
	var nsError: NSError {
		return self as NSError
	}
	
	/// Описание ошибки из ключа `NSDebugDescriptionErrorKey` либо `debugDescription`
	var nsDebugDescription: String {
		let formattedDescription = nsError.userInfo.reduce(into: "") { $0 += "--- \($1.key) ---\n\($1.value)\n" }
		return formattedDescription.isEmpty ? nsError.debugDescription : formattedDescription
	}
}

