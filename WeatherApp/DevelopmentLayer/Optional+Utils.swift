//
//  Optional+Utils.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import Foundation

extension Optional where Wrapped: Collection {
	/// Инверсия `isEmpty` для коллекции с опциональным типом
	var isNotEmpty: Bool {
		return map { !$0.isEmpty } ?? false
	}
}

extension Optional {
	/// Проверяет `self == nil` и вызывает остановку программу с `messageClosure`.
	/// - Returns: Оригинальный опционал
	func assertNotNil(_ messageClosure: @autoclosure () -> String) -> Self {
		return self
	}
}

extension Optional {
	/// Функциональная обёртка над оператором `??`, необходима для чейнинга.
	///
	/// 	let array: [Int]? = nil
	/// 	array.or([]).map { String($0) }
	///
	/// - Parameter default: Значение, подставляемое, если `self` содержит `nil`.
	/// - Returns: `self`, если в опционале есть значение; `default`, если `self` не содержит значения.
	func or(_ default: Wrapped) -> Wrapped {
		self ?? `default`
	}
	
	/// Позволяет соединить значения, хранящиеся в `self` и в `otherOptional`, в единый кортеж.
	///
	/// 	let a: Int? = 1
	/// 	let b: Int? = 2
	/// 	let sum = a.zip(b).map(+) // sum == .some(3)
	///
	/// - Parameter otherOptional: Другой опционал, который надо развернуть.
	/// - Returns: Кортеж с двумя развёрнутыми значениями или `nil`.
	func zip<OtherWrapped>(_ otherOptional: OtherWrapped?) -> (Wrapped, OtherWrapped)? {
		guard let lhs = self, let rhs = otherOptional else { return nil }
		return (lhs, rhs)
	}
}

extension Optional where Wrapped == String {
	var isEmpty: Bool {
		return self?.isEmpty ?? true
	}
	
	var orEmpty: String {
		return self ?? ""
	}
}

extension Optional where Wrapped == Bool {
	var orTrue: Bool {
		return self ?? true
	}
	
	var orFalse: Bool {
		return self ?? false
	}
}
