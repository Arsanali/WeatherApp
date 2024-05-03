//
//  SearchBuilder.swift
//  WeatherApp
//
//  Created by arslanali on 01.05.2024.
//

import UIKit

final class SearchBuilder {
	static func createSearchModule() -> UIViewController {
		let serviceProvider = ServiceProvider()
		let viewModel = SearchViewModelImpl(serviceProvider: serviceProvider)
		let view = SearchViewController(viewModel: viewModel)
		return view
	}
}
