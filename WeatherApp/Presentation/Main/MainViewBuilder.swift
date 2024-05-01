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
		let viewModel = MainViewModelImlp(serviceProvider: serviceProvider)
		let vc = MainViewController(viewModel: viewModel)
		return vc
	}
}
