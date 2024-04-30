//
//  Extension+Double.swift
//  WeatherApp
//
//  Created by arslanali on 30.04.2024.
//

import Foundation


extension Double {
	func convert(celvin: Double) -> Double {
		celvin - 273.15
	}
}
