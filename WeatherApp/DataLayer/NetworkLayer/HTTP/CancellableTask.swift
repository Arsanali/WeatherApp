//
//  CancellableTask.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

/// Абстрактная задача, которая может быть отменена
protocol CancellableTask: AnyObject {
	func cancel()
}

extension URLSessionTask: CancellableTask {}

