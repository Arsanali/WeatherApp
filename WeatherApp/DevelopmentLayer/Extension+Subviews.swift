//
//  Extension+Subviews.swift
//  WeatherApp
//
//  Created by arslanali on 29.04.2024.
//

import UIKit

extension UIView {
	func addSubviews(_ subviews: [UIView]) {
		subviews.forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			addSubview($0)
		}
	}
	func activateContstaint(_ constraints: [NSLayoutConstraint]) {
		NSLayoutConstraint.activate(constraints)
	}
}

