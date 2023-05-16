//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 16/05/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import SkeletonView
import Shared
import Detail

public class FavoriteViewController: UIViewController {
  
  init(viewModel: FavoriteViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Properties
  private let viewModel: FavoriteViewModel
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
  
  lazy var tblViewFavorite: UITableView = {
    let tableView = UITableView()
    tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.reuseIdentifier)
    tableView.isSkeletonable = true
    tableView.delegate = self
    tableView.dataSource = self
    tableView.showsVerticalScrollIndicator = false
    return tableView
  }()
  
  // MARK: - Lifecycle
  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.fetchSearchMovies()
    observeValues()
    statusHelper(1)
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()
    configureConstraints()
    observeValues()
  }
  
  // MARK: - Helpers
  private func observeValues() {
    tblViewFavorite.showAnimatedGradientSkeleton()
    viewModel.favoriteMovies
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] data in
        if !data.isEmpty {
          DispatchQueue.main.async {
            self?.statusHelper(1)
          }
        } else {
          self?.statusHelper(0)
        }
      }).disposed(by: disposeBag)
  }
  
  private func observeSearch() {
    tblViewFavorite.showAnimatedGradientSkeleton()
    viewModel.favoriteMovieSearch
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] data in
        if !data.isEmpty {
          print(data)
          DispatchQueue.main.async {
            self?.statusHelper(1)
          }
        } else {
          self?.statusHelper(2)
        }
      }).disposed(by: disposeBag)
  }
  
  private func statusHelper(_ status:Int){
    lblSearchStatus.tag = status
    switch status {
    case 0:
      lblSearchStatus.text = "Favorite Movie still empty"
      lblSearchStatus.isHidden = false
      tblViewFavorite.reloadData()
      tblViewFavorite.hideSkeleton(reloadDataAfter: true)
    case 1:
      lblSearchStatus.isHidden = true
      tblViewFavorite.isHidden = false
      tblViewFavorite.reloadData()
      tblViewFavorite.hideSkeleton(reloadDataAfter: true)
    case 2:
      view.addSubview(lblSearchStatus)
      lblSearchStatus.text = "No Result"
      lblSearchStatus.isHidden = false
      tblViewFavorite.isHidden = true
      tblViewFavorite.reloadData()
      tblViewFavorite.hideSkeleton(reloadDataAfter: true)
    default:
      lblSearchStatus.isHidden = true
      lblSearchStatus.text = ""
      tblViewFavorite.reloadData()
      tblViewFavorite.hideSkeleton(reloadDataAfter: true)
    }
  }
  
  private func configureViews() {
    view.backgroundColor = .systemBackground
    
    navigationItem.titleView = searchBar
    
    tblViewFavorite.addSubview(lblSearchStatus)
    view.addSubview(tblViewFavorite)
  }
  
  private func configureConstraints() {
    let safeArea = view.safeAreaLayoutGuide
    
    tblViewFavorite.snp.makeConstraints { make in
      make.top.equalTo(safeArea).offset(5)
      make.left.right.equalTo(safeArea).inset(10)
      make.bottom.equalTo(safeArea)
    }
    
    lblSearchStatus.snp.makeConstraints { make in
      make.center.equalTo(safeArea)
    }
  }
}

// MARK: - UISearchBarDelegate
extension FavoriteViewController: UISearchBarDelegate {
  public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let text = searchBar.text {
      viewModel.favoriteMovieSearched(input: text)
      observeSearch()
      self.view.endEditing(true)
    }
  }
  
  public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.count == 0 {
      viewModel.clearFavoriteMovieSearch()
      observeValues()
    }
  }
}
// MARK: - SkeletonTableViewDataSource

extension FavoriteViewController: SkeletonTableViewDataSource {
  public func numSections(in collectionSkeletonView: UITableView) -> Int {
    return 1
  }
  
  public func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if viewModel.favoriteMovieSearch.value.isEmpty {
      return viewModel.favoriteMovies.value.count
    } else {
      return viewModel.favoriteMovieSearch.value.count
    }
  }
  
  public func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
    return FavoriteTableViewCell.reuseIdentifier
  }
  
  public func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
    guard let cell = skeletonView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseIdentifier, for: indexPath) as? FavoriteTableViewCell else { return UITableViewCell()}
    if viewModel.favoriteMovieSearch.value.isEmpty {
      cell.item = viewModel.favoriteMovies.value[indexPath.row]
    } else {
      cell.item = viewModel.favoriteMovieSearch.value[indexPath.row]
    }
    return cell
  }
}

// MARK: - UITableViewDataSource
extension FavoriteViewController: UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if viewModel.favoriteMovieSearch.value.isEmpty {
      return viewModel.favoriteMovies.value.count
    } else {
      return viewModel.favoriteMovieSearch.value.count
    }
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseIdentifier, for: indexPath) as? FavoriteTableViewCell else { return UITableViewCell()}
    if viewModel.favoriteMovieSearch.value.isEmpty {
      cell.item = viewModel.favoriteMovies.value[indexPath.row]
    } else {
      cell.item = viewModel.favoriteMovieSearch.value[indexPath.row]
    }
    return cell
  }
}

// MARK: - UITableViewDelegate
extension FavoriteViewController: UITableViewDelegate {
  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120.0
  }
  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    var selectedMovieId: Int?
    
    selectedMovieId = viewModel.favoriteMovies.value[indexPath.row].id
    
    guard let movieId = selectedMovieId else { return }
    let detailVC = DetailModule().container.resolve(DetailViewController.self)!
    detailVC.movieId = movieId
    detailVC.hidesBottomBarWhenPushed = true
    navigationController?.pushViewController(detailVC, animated: true)
  }
}

