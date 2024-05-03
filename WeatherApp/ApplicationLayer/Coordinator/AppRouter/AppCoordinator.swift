//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by arslanali on 02.05.2024.
//

import UIKit

protocol AppRouterProtocol: AnyObject {
	func start()
}

final class AppRouter {
	let navigationController = UINavigationController()
	private var window: UIWindow?
	let serviceProvider: ServiceProvider = ServiceProvider()
	
	init(window: UIWindow = UIWindow()) {
		self.window = window
	}
}

extension AppRouter: AppRouterProtocol {
	func start() {
		let tabBar = MainTabBar()
		window?.rootViewController = tabBar
		window?.makeKeyAndVisible()
	}
}


