//
//  MainTabBar.swift
//  WeatherApp
//
//  Created by arslanali on 28.04.2024.
//

import UIKit

import UIKit

private enum TabBarItem: Int, CaseIterable {
	case main
	case search
	case settings
	
	var iconName: String {
		switch self {
		case .main: return "main"
		case .search: return "search"
		case .settings: return "settings"
		}
	}
	
	var title: String {
		switch self {
		case .main: return "main"
		case .search: return "search"
		case .settings: return "settings"
		}
	}
}

class MainTabBar: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		drawSelf()
		configureTabBar()
	}
	
	
	// MARK: - Methods
	
	private func drawSelf() {
		viewControllers = TabBarItem.allCases.map {
			let viewController: UIViewController
			
			switch $0 {
			case .main:
				viewController = MainViewController()
			case .search:
				viewController = SearchViewController()
			case .settings:
				viewController = SettingsViewController()
			}
			viewController.title = $0.title
			viewController.configure(title: $0.title)
			return viewController.wrappedInNavigationController()
		}
	}
	
	private func configureTabBar() {
		tabBar.isTranslucent = false
		tabBar.backgroundImage = UIImage()
		tabBar.shadowImage = UIImage()
		tabBar.tintColor = .black
		
	}
	
}

extension UIViewController {
	
	func configure(title: String) {
		let tabBarAppearance = UITabBar.appearance()
		tabBarAppearance.tintColor = .black
		tabBarItem.title = title
	}
	
	func wrappedInNavigationController() -> UINavigationController {
		return UINavigationController(rootViewController: self)
	}
}
