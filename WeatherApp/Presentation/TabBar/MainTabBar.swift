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
	
	var iconName: String {
		switch self {
		case .main: return "main"
		case .search: return "search"
		}
	}
	
	var title: String {
		switch self {
		case .main: return "main".localized()
		case .search: return "search".localized()
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
				viewController = MainViewBuilder.createModule()
			case .search:
				viewController = SearchBuilder.createSearchModule()
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
