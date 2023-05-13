//
//  PeopleSearchViewController.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 13.05.2023.
//

import UIKit
import Combine

protocol PeopleSearchViewControllerDelegate: AnyObject {
    func selectedProfile(profile: User)
}

final class PeopleSearchViewController: UIViewController, StoryboardInstantiable {

    private enum Constants {
        static let cellHeight: CGFloat = 100
        static let cellReuseIdentifier = "PeopleSearchCell"
    }

    weak var delegate: PeopleSearchViewControllerDelegate?
    private let viewModel = PeopleSearchViewModel()
    private var cancellables = Set<AnyCancellable>()
    private let searchController = UISearchController()

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let cellNib = UINib(nibName: Constants.cellReuseIdentifier, bundle: nil)
            collectionView.register(cellNib, forCellWithReuseIdentifier: Constants.cellReuseIdentifier)
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
            withReuseIdentifier: Constants.cellReuseIdentifier,
            for: indexPath
        ) as? PeopleSearchCell else {
            fatalError()
        }
        cell.setupCell(model: viewModel.cellModelFor(indexPath.item))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.profiles.count
    }
}

extension PeopleSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: Constants.cellHeight)
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

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.cancel()
    }
}

extension PeopleSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectedProfile(profile: viewModel.profiles[indexPath.item])
    }
}
