//
//  City.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

// MARK: - City
struct City: Decodable {
	let coord: Coord?
	let weather: [Weather]?
	let base: String?
	let main: Main?
	let visibility: Int?
	let wind: Wind?
	let clouds: Clouds?
	let dt: Int?
	let sys: Sys?
	let timezone, id: Int?
	let name: String
	let cod: Int?
}

// MARK: - Clouds
struct Clouds: Decodable {
	let all: Int?
}

// MARK: - Coord
struct Coord: Decodable {
	let lat, lon: Double?
}

// MARK: - Main
struct Main: Decodable {
	let temp, feelsLike, tempMin, tempMax: Double?
	let pressure, humidity, seaLevel, grndLevel: Int?
	
	enum CodingKeys: String, CodingKey {
		case temp
		case feelsLike = "feels_like"
		case tempMin = "temp_min"
		case tempMax = "temp_max"
		case pressure, humidity
		case seaLevel = "sea_level"
		case grndLevel = "grnd_level"
	}
}

// MARK: - Sys
struct Sys: Decodable {
	let type, id: Int?
	let country: String?
	let sunrise, sunset: Int?
}

// MARK: - Weather
struct Weather: Decodable {
	let id: Int?
	let main, description, icon: String?
}

// MARK: - Wind
struct Wind: Decodable {
	let speed: Double?
	let deg: Int?
	let gust: Double?
}
