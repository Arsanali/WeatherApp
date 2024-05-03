//
//  ResumebleTask.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// Абстрактная задача, которая может быть запущена
protocol ResumebleTask {
	func resume()
}

extension URLSessionTask: ResumebleTask {}
