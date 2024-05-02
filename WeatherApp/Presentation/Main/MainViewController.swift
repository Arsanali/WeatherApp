//
//  MainViewController.swift
//  WeatherApp
//
//  Created by arslanali on 28.04.2024.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController, UpdateTableViewDelegate {

	private var viewModel: MainViewModel
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.delegate = self
		tableView.dataSource = self
		return tableView
	}()
	
	init(viewModel: MainViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupViews()
		setupObservers()
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
	
	func reloadData(sender: MainViewModel) {
		self.tableView.reloadData()
	}

	private func setupObservers() {
		NotificationCenter.default.addObserver(forName: Notification.Name("SearchViewModelCityUpdated"), object: nil, queue: nil) { [weak self] _ in
			DispatchQueue.main.async {
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
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}

	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] (action, view, completionHandler) in
			self?.viewModel.deleteCity(indexPath: indexPath)
			DispatchQueue.main.async {
				tableView.deleteRows(at: [indexPath], with: .automatic)
				completionHandler(true)
			}
		}
		return UISwipeActionsConfiguration(actions: [deleteAction])
	}
	
	//TODO: - вынести этот код в Coordinator
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let model = viewModel.object(indexPath: indexPath)
		guard let lat = model?.lat, let lon = model?.lon else { return }
		viewModel.didSelectCity(lat: lat, lon: lon)
	}
}
