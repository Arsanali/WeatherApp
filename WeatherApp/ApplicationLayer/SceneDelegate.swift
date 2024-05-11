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
	private var appRouter: AppRouter?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		configureScene(scene)
	}
	
	func configureScene(_ scene: UIScene) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window?.windowScene = windowScene
		
		if let window = self.window {
			appRouter = AppRouter(window: window)
			appRouter?.start()
		}

	}
	func sceneDidEnterBackground(_ scene: UIScene) {
		appRouter?.serviceProvider.dataManager.saveContext()
	}
}
