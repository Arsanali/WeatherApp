//
//  ModuleTransitionHandler.swift
//  WeatherApp
//
//  Created by arslanali on 02.05.2024.
//

import UIKit

protocol ModuleTransitionHandler: AnyObject {
	func push<ModuleType: Assembly>(with model: TransitionModel, openModuleType: ModuleType.Type)
	func push<ModuleType: Assembly>(moduleType: ModuleType.Type)
	func pop()
	func popToRootViewController()
	func closeModule()
	func closeModule(_ completion: (() -> Void)?)
}

extension UIViewController: ModuleTransitionHandler {
	
	func pop() {
		guard let navigationController = navigationController else { return }
		navigationController.popViewController(animated: true)
	}
	
	func popToRootViewController() {
		guard let navigationController = navigationController else { return }
		navigationController.popToRootViewController(animated: true)
	}
	
	func push<ModuleType: Assembly>(with model: TransitionModel, openModuleType: ModuleType.Type) {
		guard let navigationController = navigationController else { return }
		let viewController = ModuleType.assembleModule(with: model)
		navigationController.pushViewController(viewController, animated: true)
	}
	
	func push<ModuleType: Assembly>(moduleType: ModuleType.Type) {
		guard let navigationController = navigationController else { return }
		let viewController = ModuleType.assembleModule()
		navigationController.pushViewController(viewController, animated: true)
	}
	
	func closeModule() {
		closeModule(nil)
	}
	
	func closeModule(_ completion: (() -> Void)?) {
		dismiss(animated: true, completion: completion)
	}
}
