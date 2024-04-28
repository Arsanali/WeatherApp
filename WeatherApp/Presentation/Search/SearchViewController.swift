//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by arslanali on 28.04.2024.
//

import UIKit

final class SearchViewController: UIViewController {

	
	private lazy var searchBar: UISearchBar = {
		let searchBar = UISearchBar()
		searchBar.delegate = self
		return searchBar
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupViews()
    }
	
	private func setupViews() {
		view.backgroundColor = .white
		view.addSubview(searchBar)
		
		searchBar.snp.makeConstraints {
			$0.top.equalTo(view.safeAreaLayoutGuide)
			$0.leading.equalToSuperview().offset(12)
			$0.trailing.equalToSuperview().offset(-12)
		}
	}


}


extension SearchViewController: UISearchBarDelegate  {
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		
	}
}
