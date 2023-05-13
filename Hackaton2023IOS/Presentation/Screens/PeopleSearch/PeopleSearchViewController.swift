//
//  PeopleSearchViewController.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 13.05.2023.
//

import UIKit
import Combine

final class PeopleSearchViewController: UIViewController, StoryboardInstantiable {

    private let viewModel = PeopleSearchViewModel()
    private var cancellables = Set<AnyCancellable>()
    private let searchController = UISearchController()

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let cellNib = UINib(nibName: "PeopleSearchCell", bundle: nil)
            collectionView.register(cellNib, forCellWithReuseIdentifier: "PeopleSearchCell")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        collectionView.dataSource = self
        collectionView.delegate = self

        viewModel.reloadSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
            self?.collectionView.reloadData()
        }.store(in: &cancellables)
    }
}

extension PeopleSearchViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "PeopleSearchCell",
            for: indexPath
        ) as? PeopleSearchCell else {
            fatalError()
        }
        cell.setupCell(model: viewModel.results[indexPath.item])
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.results.count
    }
}

extension PeopleSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 100)
    }
}

extension PeopleSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        searchBar.endEditing(true)
        viewModel.search(promt: text)
    }
}
