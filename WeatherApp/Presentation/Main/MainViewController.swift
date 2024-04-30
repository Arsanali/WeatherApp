//
//  MainViewController.swift
//  WeatherApp
//
//  Created by arslanali on 28.04.2024.
//

import UIKit
import SnapKit
import CoreData

final class MainViewController: UIViewController, UpdateTableViewDelegate {

	private var viewModel = MainViewModelImlp()
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.delegate = self
		tableView.dataSource = self
		return tableView
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		setupViews()
		setupObservers()
		loadData()
		self.viewModel.delegate = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "сell")
    }
	
	private func setupViews() {
		view.backgroundColor = .white
		view.addSubviews([tableView])
		
		tableView.snp.makeConstraints {
			$0.top.equalToSuperview()
			$0.leading.equalToSuperview()
			$0.trailing.equalToSuperview()
			$0.bottom.equalToSuperview()
		}
	}
	
	@objc private func loadData() {
		viewModel.retrieveDataFromCoreData()
	}
	
	func reloadData(sender: MainViewModelImlp) {
		self.tableView.reloadData()
	}

	private func setupObservers() {
		NotificationCenter.default.addObserver(forName: Notification.Name("SearchViewModelCityUpdated"), object: nil, queue: nil) { [weak self] _ in
			DispatchQueue.main.async {
				self?.loadData()
				self?.tableView.reloadData()
			}
		}
	}
	
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfRowsInSection(section: section)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "сell", for: indexPath)
		if let object = viewModel.object(indexPath: indexPath) {
			cell.textLabel?.text = object.name
		} else {
			cell.textLabel?.text = "Unknown"
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}

	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] (action, view, completionHandler) in
			self?.viewModel.deleteCity(indexPath: indexPath)
			completionHandler(true)
		}
		
		return UISwipeActionsConfiguration(actions: [deleteAction])
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = DetailCityViewController()
		let model = viewModel.object(indexPath: indexPath)
		let city = model.map { City(coord: nil, weather: nil, base: nil, main: nil, visibility: nil, wind: nil, clouds: nil, dt: nil, sys: nil, timezone: nil, id: nil, name: $0.name ?? "", cod: nil)}
		if let city = city {
			vc.configureView(city: city)
			navigationController?.pushViewController(vc, animated: true)
		}
	}
}
