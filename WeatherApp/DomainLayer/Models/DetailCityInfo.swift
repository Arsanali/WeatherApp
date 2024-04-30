//
//  DetailCityInfo.swift
//  WeatherApp
//
//  Created by arslanali on 30.04.2024.
//

import Foundation

// MARK: - DetailCityInfo
struct DetailCityInfo: Decodable {
	let cod: String?
	let message, cnt: Int?
	let list: [ListInfo]?
	let city: DetailCity?
}

// MARK: - City
struct DetailCity: Decodable {
	let id: Int?
	let name: String?
	let coord: Coordinate?
	let country: String?
	let population, timezone, sunrise, sunset: Int?
}

// MARK: - Coord
struct Coordinate: Decodable {
	let lat, lon: Double?
}

// MARK: - List
struct ListInfo: Decodable {
	let dt: Int?
	let main: MainClass?
	let weather: [WeatherInfo]?
	let clouds: Clouds?
	let wind: Wind?
	let visibility: Int?
	let pop: Double?
	let sys: Sys?
	let dtTxt: String?
	
	enum CodingKeys: String, CodingKey {
		case dt, main, weather, clouds, wind, visibility, pop, sys
		case dtTxt = "dt_txt"
	}
}

// MARK: - Clouds
struct CloudsDetail: Decodable {
	let all: Int?
}

// MARK: - MainClass
struct MainClass: Decodable {
	let temp, feelsLike, tempMin, tempMax: Double?
	let pressure, seaLevel, grndLevel, humidity: Int?
	let tempKf: Double?
	
	enum CodingKeys: String, CodingKey {
		case temp
		case feelsLike = "feels_like"
		case tempMin = "temp_min"
		case tempMax = "temp_max"
		case pressure
		case seaLevel = "sea_level"
		case grndLevel = "grnd_level"
		case humidity
		case tempKf = "temp_kf"
	}
}

//// MARK: - Sys
//struct Sys: Decodable {
//	let pod: Pod?
//}

enum Pod: String, Codable {
	case d = "d"
	case n = "n"
}

// MARK: - Weather
struct WeatherInfo: Decodable {
	let id: Int?
	let main: MainEnum?
	let description: Description?
	let icon: Icon?
}

enum Description: String, Decodable {
	case brokenClouds = "broken clouds"
	case fewClouds = "few clouds"
	case overcastClouds = "overcast clouds"
	case scatteredClouds = "scattered clouds"
}

enum Icon: String, Decodable {
	case the02D = "02d"
	case the03D = "03d"
	case the04D = "04d"
	case the04N = "04n"
}

enum MainEnum: String, Decodable {
	case clouds = "Clouds"
}

// MARK: - Wind
struct WindDetail: Decodable {
	let speed: Double?
	let deg: Int?
	let gust: Double?
}
