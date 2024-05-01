//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by arslanali on 01.05.2024.
//

import UIKit

final class WeatherCell: UITableViewCell {
	
	private lazy var temperatureLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 18)
		return label
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupViews() {
		contentView.addSubviews([temperatureLabel])
		
		temperatureLabel.snp.makeConstraints {
			$0.leading.equalToSuperview().offset(12)
			$0.top.equalToSuperview().offset(12)
		}
	}
	
	func configure(_ listInfo: ListInfo) {
		guard let temp = listInfo.main?.temp  else { return }
		let kelvin = temp - 273.15
		temperatureLabel.text = "\(String(describing: kelvin))"
	}
}
