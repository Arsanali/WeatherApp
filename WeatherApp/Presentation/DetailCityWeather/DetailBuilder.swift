//
//  DetailBuilder.swift
//  WeatherApp
//
//  Created by arslanali on 02.05.2024.
//

import UIKit

final class DetailBuilder {
	static func createModule(model: Model) -> UIViewController {
		let serviceProvider = ServiceProvider()
		let viewModel = DetailCityViewModelImpl(serviceProvider: serviceProvider, lat: model.lat, lon: model.lon)
		let view = DetailCityViewController(viewModel: viewModel)
		return view
	}
}

struct Model {
	let lat: Double
	let lon: Double
}
