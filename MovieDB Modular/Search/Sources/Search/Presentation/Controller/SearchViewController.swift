//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 16/05/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import SkeletonView
import Shared
import Detail

public class SearchViewController: UIViewController {
  
  init(viewModel: SearchViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Properties
  private let viewModel: SearchViewModel
  private let disposeBag = DisposeBag()
  
  private lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "Find what kind of you want..."
    searchBar.delegate = self
    return searchBar
  }()
  
  private lazy var lblSearchStatus: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 18)
    label.textColor = UIColor.tertiaryLabel
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "You can use the searchbar"
    return label
  }()
  
  private lazy var colSearchedMovies: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 170, height: 280)
    layout.scrollDirection = .vertical
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdentifier)
    collectionView.isSkeletonable = true
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = UIColor.systemBackground
    collectionView.showsVerticalScrollIndicator = false
    return collectionView
  }()
  // MARK: - Lifecycle
  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()
    configureConstraints()
    statusHelper(0)
  }
  
  // MARK: - Helpers
  private func configureViews() {
    view.backgroundColor = .systemBackground
    
    navigationItem.titleView = searchBar
    
    colSearchedMovies.addSubview(lblSearchStatus)
    view.addSubview(colSearchedMovies)
  }
  
  private func configureConstraints() {
    let safeArea = view.safeAreaLayoutGuide
    
    colSearchedMovies.snp.makeConstraints { make in
      make.top.equalTo(safeArea).offset(10)
      make.left.right.bottom.equalTo(safeArea).inset(10)
    }
    
    lblSearchStatus.snp.makeConstraints { make in
      make.center.equalTo(safeArea)
    }
  }
  
  private func statusHelper(_ status:Int){
    lblSearchStatus.tag = status
    switch status {
    case 0:
      lblSearchStatus.text = "You can use searchbar"
      lblSearchStatus.isHidden = false
      colSearchedMovies.reloadData()
      colSearchedMovies.hideSkeleton(reloadDataAfter: true)
    case 1:
      lblSearchStatus.isHidden = true
      colSearchedMovies.showAnimatedSkeleton()
    case 2:
      lblSearchStatus.text = "No Result"
      lblSearchStatus.isHidden = false
      colSearchedMovies.reloadData()
      colSearchedMovies.hideSkeleton(reloadDataAfter: true)
    case 3:
      lblSearchStatus.isHidden = true
      colSearchedMovies.reloadData()
      colSearchedMovies.hideSkeleton(reloadDataAfter: true)
    default:
      lblSearchStatus.isHidden = true
      lblSearchStatus.text = ""
      colSearchedMovies.reloadData()
      colSearchedMovies.hideSkeleton(reloadDataAfter: true)
    }
  }
  
  private func observeValues() {
    viewModel.searchMovies
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] data in
        if !data.isEmpty {
          DispatchQueue.main.async {
            self?.statusHelper(1)
            self?.colSearchedMovies.hideSkeleton(reloadDataAfter: true)
            self?.colSearchedMovies.reloadSections(IndexSet(integer: 0))
          }
        } else {
          self?.statusHelper(0)
        }
      }).disposed(by: disposeBag)
  }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
  public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let text = searchBar.text {
      viewModel.fetchSearchMovies(input: text)
      statusHelper(1)
      observeValues()
      self.view.endEditing(true)
    }
  }
  
  public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.count == 0 {
      viewModel.clearMovieSearch()
      observeValues()
    }
  }
}

// MARK: - SkeletonCollectionViewDataSource & SkeletonCollectionViewDelegate
extension SearchViewController: SkeletonCollectionViewDataSource, SkeletonCollectionViewDelegate {
  public func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
    if skeletonView == colSearchedMovies {
      return SearchCollectionViewCell.reuseIdentifier
    }
    return SearchCollectionViewCell.reuseIdentifier
  }
  
  public func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let count = viewModel.searchMovies.value.count
    if lblSearchStatus.tag == 0 {
      statusHelper(0)
    } else if count <= 0 {
      statusHelper(2)
    } else {
      statusHelper(3)
    }
    return count
  }
  
  // MARK: - UICollectionViewDataSource
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let count = viewModel.searchMovies.value.count
    if lblSearchStatus.tag == 0 {
      statusHelper(0)
    } else if count <= 0 {
      statusHelper(2)
    } else {
      statusHelper(3)
    }
    return count
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell()}
    cell.item = viewModel.searchMovies.value[indexPath.row]
    return cell
  }
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    var selectedMovieId: Int?
    
    selectedMovieId = viewModel.searchMovies.value[indexPath.row].id
    
    guard let movieId = selectedMovieId else { return }
    let detailVC = DetailModule().container.resolve(DetailViewController.self)!
    detailVC.movieId = movieId
    detailVC.hidesBottomBarWhenPushed = true
    navigationController?.pushViewController(detailVC, animated: true)
  }
}

