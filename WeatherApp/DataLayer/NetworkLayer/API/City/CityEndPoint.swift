//
//  CityEndPoint.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

enum CityEndPoint {
	case searchCity(city: String)
	case detailInfoCity(lat: Double, lon: Double)
}

extension CityEndPoint: Endpointable {
	
	var path: String {
		switch self {
		case .searchCity: return "weather"
		case .detailInfoCity: return "forecast"
		}
	}
	
	var httpMethod: HTTPMethod {
		switch self {
		case .searchCity, .detailInfoCity:
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
		case let .detailInfoCity(lat: lat, lon: lon):
			return.requestWithoutParameters(
				bodyEncoding: .urlEncoding,
				urlParameters: [
					"lat": lat,
					"lon": lon,
					"appid": "f81c48c4fb46c335e23fe930b2bb4d04"
				]
			)
		}
	}
}
