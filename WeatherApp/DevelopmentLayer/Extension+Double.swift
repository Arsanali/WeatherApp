//
//  Extension+Double.swift
//  WeatherApp
//
//  Created by arslanali on 30.04.2024.
//

import Foundation


extension Double {
	func kelvinToCelsius(_ temperatureInKelvin: Double) -> String {
		let temperatureInCelsius = temperatureInKelvin - 273.15
		let formattedTemperature = String(format: "%.1f", temperatureInCelsius)
		return formattedTemperature
	}
}
