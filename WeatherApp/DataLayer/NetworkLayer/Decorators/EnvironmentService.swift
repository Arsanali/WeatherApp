//
//  EnvironmentService.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

final class EnvironmentService: NetworkEnvironment {
	private(set) var decorators: [NetworkDecorator] = []
	
	var current: Environment {
		// TODO: Реализовать смену сессии путем перезаписи сущности в UD или подобное хранилище
#if DEBUG || STAGE
		return .production
#elseif QA
		return .production
#else
		return .production
#endif
	}
	
	/// Обновляет список декораторов, заменяя текущие
	/// - Parameter decorators: новый список декораторов
	func update(decorators: [NetworkDecorator]) {
		self.decorators = decorators
	}
}

