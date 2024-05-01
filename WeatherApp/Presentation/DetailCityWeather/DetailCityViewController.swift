//
//  DetailCityViewController.swift
//  WeatherApp
//
//  Created by arslanali on 30.04.2024.
//

import UIKit

final class DetailCityViewController: UIViewController {
	
	private var viewModel: DetailCityViewModel = DetailCityViewModelImpl()
	private var listInfo: [ListInfo] = []
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.delegate = self
		tableView.dataSource = self
		return tableView
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		setupViews()
		setupLayout()
    }
	
	private func setupViews() {
		view.backgroundColor = .white
		view.addSubviews([tableView])
		tableView.register(WeatherCell.self, forCellReuseIdentifier: "cell")
	}
	
	private func setupLayout() {
		tableView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
	}
	
	func configureView(city: City) {		
		Task {
			guard let lat = city.coord?.lat, let lon = city.coord?.lon else { return }
			Task {
				do {
					let data = try await viewModel.fetchDetailInfoCity(lat, lon)
					DispatchQueue.main.async {
						self.listInfo = data.list ?? []
						self.tableView.reloadData()
					}
				} catch {
					print("Error fetching detail city info: \(error)")
				}
			}
		}
	}

}

extension DetailCityViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return listInfo.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? WeatherCell else { 
			return UITableViewCell() }
		let info = listInfo[indexPath.row]
		cell.configure(info)
		return cell
	}
	
	
}
