//
//  DetailBuilder.swift
//  WeatherApp
//
//  Created by arslanali on 02.05.2024.
//

import UIKit

final class DetailBuilder: Assembly {
	static func assembleModule(with model: TransitionModel) -> UIViewController {
		guard let model = (model as? Model) else { return UIViewController() }
		let serviceProvider = ServiceProvider()
		let viewModel = DetailCityViewModelImpl(serviceProvider: serviceProvider, lat: model.lat, lon: model.lon)
		let view = DetailCityViewController(viewModel: viewModel)
		return view
	}
}

extension DetailBuilder {
	struct Model: TransitionModel {
		let lat: Double
		let lon: Double
	}
}
