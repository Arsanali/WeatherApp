//
//  CityEndPoint.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

enum CityEndPoint {
	case searchCity(city: String)
}

extension CityEndPoint: Endpointable {
	
	var path: String {
		switch self {
		case .searchCity: return "weather"
		}
	}
	
	var httpMethod: HTTPMethod {
		switch self {
		case .searchCity:
			return .get
		}
	}
	
	var task: HTTPTask {
		switch self {
		case let .searchCity(city: city):
			return.requestWithoutParameters(
				bodyEncoding: .urlEncoding,
				urlParameters: [
					"q": city,
					"appid": "f81c48c4fb46c335e23fe930b2bb4d04"
				]
			)
		}
	}
}
