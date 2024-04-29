//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by arslanali on 28.04.2024.
//

import UIKit
import Combine
import CombineCocoa

final class SearchViewController: UIViewController {

	private var searchViewModelImpl = SearchViewModelImpl()
	private var cityModel: [City] = []
	private var cancellables: Set<AnyCancellable> = []
	
	private lazy var searchBar: UISearchBar = {
		let searchBar = UISearchBar()
		searchBar.delegate = self
		return searchBar
	}()
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.delegate = self
		tableView.dataSource = self
		return tableView
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupViews()
		setup()
		
    }
	
	private func setupViews() {
		view.backgroundColor = .white
		view.addSubviews([searchBar, tableView])
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		
		searchBar.snp.makeConstraints {
			$0.top.equalTo(view.safeAreaLayoutGuide)
			$0.leading.equalToSuperview().offset(12)
			$0.trailing.equalToSuperview().offset(-12)
		}
		
		tableView.snp.makeConstraints {
			$0.top.equalTo(searchBar.snp.bottom).offset(10)
			$0.leading.equalToSuperview()
			$0.trailing.equalToSuperview()
			$0.bottom.equalToSuperview()
		}
	}
	
	private func setup() {
		searchBar.textDidChangePublisher
			.debounce(for: 0.5, scheduler: DispatchQueue.main)
			.compactMap { $0 }
			.sink { [weak self] searchText in
				self?.searchSity(searchText)
			}.store(in: &cancellables)
		
	}
	
	private func searchSity(_ city: String) {
		Task {
			do {
				let model = try await searchViewModelImpl.fetchCity(city: city)
				self.cityModel = [model]
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			} catch {
				print("Error fetching city: \(error)")
			}
		}
	}
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cityModel.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		let model = cityModel[indexPath.row].name
		cell.textLabel?.text = model
		return cell
	}
}

extension SearchViewController: UISearchBarDelegate  {
	
//	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//		if let searchText = searchBar.text, !searchText.isEmpty {
//			searchSity(searchText)
//		}
//	}
}
