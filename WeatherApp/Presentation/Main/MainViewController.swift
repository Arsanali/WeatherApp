//
//  MainViewController.swift
//  WeatherApp
//
//  Created by arslanali on 28.04.2024.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {

	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.delegate = self
		tableView.dataSource = self
		return tableView
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupViews()
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
	
	private func setupViews() {
		view.backgroundColor = .white
		view.addSubview(tableView)
		
		tableView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
	}
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = "\(indexPath.row) text"
		return cell
	}
}

