//
//  Localized.swift
//  WeatherApp
//
//  Created by arslanali on 01.05.2024.
//

import Foundation

extension String {
	func localized() -> String {
		NSLocalizedString(self,tableName: "Localizable", bundle: .main, value: self, comment: self)
	}
}
