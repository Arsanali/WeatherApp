//
//  DetailCityViewController.swift
//  WeatherApp
//
//  Created by arslanali on 30.04.2024.
//

import UIKit

final class DetailCityViewController: UIViewController {
	
	private var viewModel: DetailCityViewModel = DetailCityViewModelImpl()
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
		nameCityLabel.text = city.name
		
		Task {
			guard let lat = city.coord?.lat, let lon = city.coord?.lon else { return }
			let data = try await viewModel.fetchDetailInfoCity(lat, lon)
			print("Детальная информация запроса,\(data)")
		}
	}

}
