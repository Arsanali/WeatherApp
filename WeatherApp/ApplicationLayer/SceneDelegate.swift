//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by arslanali on 28.04.2024.
//

import UIKit
import SceneKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	private let serviceProvider = ServiceProvider()

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		let tabBar = MainTabBar()
		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window?.windowScene = windowScene
		window?.rootViewController = tabBar
		window?.makeKeyAndVisible()
	}

	func sceneDidDisconnect(_ scene: UIScene) {
		
	}

	func sceneDidBecomeActive(_ scene: UIScene) {
		
	}

	func sceneWillResignActive(_ scene: UIScene) {
		
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
		
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		serviceProvider.dataManager.saveContext()
	}
}
