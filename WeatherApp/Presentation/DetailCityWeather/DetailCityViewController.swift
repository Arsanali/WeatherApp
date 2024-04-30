//
//  DetailCityViewController.swift
//  WeatherApp
//
//  Created by arslanali on 30.04.2024.
//

import UIKit

final class DetailCityViewController: UIViewController {
	
	private lazy var nameCityLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 18)
		return label
	}()
	
	private lazy var temperatureLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 18)
		return label
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		setupViews()
		setupLayout()
    }
	
	private func setupViews() {
		view.backgroundColor = .white
		view.addSubviews([nameCityLabel, temperatureLabel])
		
		
	}
	
	private func setupLayout() {
		nameCityLabel.snp.makeConstraints {
			$0.leading.equalToSuperview().offset(16)
			$0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
		}
		
		temperatureLabel.snp.makeConstraints {
			$0.leading.equalToSuperview().offset(16)
			$0.top.equalTo(nameCityLabel.snp.bottom).offset(10)
		}
		
	}
	
	func configureView(city: City) {
		guard let temp = city.main?.temp else { return }
		nameCityLabel.text = city.name
		temperatureLabel.text = "\(273.15 - temp)"
		
	}

}
