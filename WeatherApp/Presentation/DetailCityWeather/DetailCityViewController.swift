//
//  DetailCityViewController.swift
//  WeatherApp
//
//  Created by arslanali on 30.04.2024.
//

import UIKit

final class DetailCityViewController: UIViewController {
	
	private var viewModel: DetailCityViewModel
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(WeatherCell.self, forCellReuseIdentifier: "cell")
		return tableView
	}()
	
	init(viewModel: DetailCityViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupViews()
		setupLayout()
		setupBinding()
		fetchDetailInfoCity()
    }

	private func setupViews() {
		view.backgroundColor = .white
		view.addSubviews([tableView])
	}
	
	private func setupLayout() {
		tableView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
	}
	
	func setupBinding() {
		viewModel.listInfoPublisher.sink { _ in
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}.store(in: &viewModel.cancellables)
	}
	
	func fetchDetailInfoCity() {
		self.viewModel.fetchDetailInfoCity()
	}
}

extension DetailCityViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.listInfo.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? WeatherCell else { 
			return UITableViewCell() }
		return cell
	}

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if let weatherCell = cell as? WeatherCell {
			let info = viewModel.listInfo[indexPath.row]
			weatherCell.configure(info)
		}
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 80
	}
	
}
