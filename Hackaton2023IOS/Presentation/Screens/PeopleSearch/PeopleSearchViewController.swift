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
        static let navBarTitle = "People search"
    }

    weak var delegate: PeopleSearchViewControllerDelegate?
    var viewModel: PeopleSearchViewModel?
    private var cancellables = Set<AnyCancellable>()
    private let searchController = UISearchController()
    private var animationView: SearchAnimationView?

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let cellNib = UINib(nibName: Constants.cellReuseIdentifier, bundle: nil)
            collectionView.register(cellNib, forCellWithReuseIdentifier: Constants.cellReuseIdentifier)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchControllerSetup()
        setupNavigationBar()
        setupCollectionView()
        bindViewModel()
        setupAnimation()
    }

    // MARK: - Private setup functions

    private func searchControllerSetup() {
        searchController.searchBar.delegate = self
    }

    private func setupAnimation() {
        let animationView = SearchAnimationView(frame: view.bounds)
        view.addSubview(animationView)
        self.animationView = animationView
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func setupNavigationBar() {
        navigationItem.searchController = searchController
        navigationItem.title = Constants.navBarTitle
    }

    private func bindViewModel() {
        viewModel?.stateSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .idle:
                    self?.collectionView.reloadData()
                    self?.animationView?.isHidden = false
                    self?.animationView?.stop()

                case .animating:
                    self?.animationView?.isHidden = false
                    self?.animationView?.play()

                case .reloadData:
                    self?.collectionView.reloadData()
                    self?.animationView?.isHidden = true
                    self?.animationView?.stop()
                }
        }.store(in: &cancellables)
    }
}

// MARK: - UICollectionViewDataSource

extension PeopleSearchViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let viewModel,
              let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.cellReuseIdentifier,
            for: indexPath
        ) as? PeopleSearchCell else {
            return UICollectionViewCell()
        }
        cell.setupCell(model: viewModel.cellModelFor(indexPath.item))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.profiles.count ?? 0
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PeopleSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: Constants.cellHeight)
    }
}

// MARK: - UISearchBarDelegate

extension PeopleSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, let viewModel else {
            return
        }
        searchBar.endEditing(true)
        viewModel.search(promt: text)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.cancel()
    }
}

// MARK: - UICollectionViewDelegate

extension PeopleSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel else { return }
        delegate?.selectedProfile(profile: viewModel.profiles[indexPath.item])
    }
}
