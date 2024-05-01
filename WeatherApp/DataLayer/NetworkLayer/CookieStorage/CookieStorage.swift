//
//  CookieStorage.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// Интерфейс взаимодействия с хранилищем печенек
protocol CookieStorage: AnyObject {
	var cookies: [HTTPCookie]? { get }
}

extension HTTPCookieStorage: CookieStorage {}
