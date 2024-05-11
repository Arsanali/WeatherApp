//
//  MainViewBuilder.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation
import CoreData
import UIKit

final class MainViewBuilder {
	static func createModule() -> UIViewController {
		let serviceProvider = ServiceProvider()
		let viewModel = MainViewModelImpl(serviceProvider: serviceProvider)
		let view = MainViewController(viewModel: viewModel)
		let router = MainRouter(transition: view)
		viewModel.router = router
		return view
	}
}
