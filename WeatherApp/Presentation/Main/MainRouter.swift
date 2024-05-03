//
//  MainRouter.swift
//  WeatherApp
//
//  Created by arslanali on 02.05.2024.
//

import Foundation

protocol MainRouterInput {
	func openDetailView(lat: Double, lon: Double)
}

final class MainRouter: MainRouterInput{
	
	weak var transition: ModuleTransitionHandler?
	
	init(transition: ModuleTransitionHandler?) {
		self.transition = transition
	}
	
	func openDetailView(lat: Double, lon: Double) {
		transition?.push(with: DetailBuilder.Model(lat: lat, lon: lon),
							openModuleType: DetailBuilder.self)
	}
}
