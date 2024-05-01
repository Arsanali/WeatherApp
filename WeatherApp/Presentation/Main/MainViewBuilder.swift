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
		let viewModel = MainViewModelImlp()
		let vc = MainViewController(viewModel: viewModel)
		return vc
	}
}
