//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by arslanali on 01.05.2024.
//

import UIKit

final class WeatherCell: UITableViewCell {
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.text = "weather".localized()
		label.font = .systemFont(ofSize: 18)
		return label
	}()
	
	private lazy var dateLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 18)
		return label
	}()
	
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
		contentView.addSubviews([temperatureLabel, titleLabel, dateLabel])
		
		titleLabel.snp.makeConstraints {
			$0.leading.equalToSuperview().offset(12)
			$0.top.equalToSuperview().offset(12)
		}
		
		temperatureLabel.snp.makeConstraints {
			$0.leading.equalTo(titleLabel.snp.trailing).offset(4)
			$0.top.equalToSuperview().offset(12)
		}
		
		dateLabel.snp.makeConstraints {
			$0.leading.equalToSuperview().offset(12)
			$0.bottom.equalToSuperview().offset(2)
		}
	}
	
	func configure(_ listInfo: ListInfo) {
		temperatureLabel.text = listInfo.main?.temp?.kelvinToCelsius(listInfo.main?.temp ?? 0)
		dateLabel.text = "\(listInfo.dtTxt ?? "")"
	}
}
