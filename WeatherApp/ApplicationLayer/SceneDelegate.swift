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
	private var appCoordinator: AppRouter?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window?.windowScene = windowScene
		
		if let window = self.window {
			appCoordinator = AppRouter(window: window)
			appCoordinator?.start()
		}
		
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
		appCoordinator?.serviceProvider.dataManager.saveContext()
	}
}
