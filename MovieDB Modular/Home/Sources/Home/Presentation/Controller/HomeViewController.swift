//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 14/05/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import SkeletonView
import Shared

public class HomeViewController: UIViewController {
  
  init(viewModel: HomeViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Properties
  
  private let viewModel: HomeViewModel
  private let disposeBag = DisposeBag()
  
  private lazy var lblPopular = reusableTitleLabel(text: "Popular Movies")
  private lazy var lblUpcoming = reusableTitleLabel(text: "Upcoming Movies")
  
  private lazy var colPopular = reusableCollectionView(identifier: "cell1")
  private lazy var colUpcoming = reusableCollectionView(identifier: "cell2")
  
  private lazy var imgFeatured: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.isSkeletonable = true
    return imageView
  }()
  
  private lazy var stckAppBar: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    return stackView
  }()
  
  private lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.isScrollEnabled = true
    scrollView.showsVerticalScrollIndicator = false
    return scrollView
  }()
  
  private lazy var contentView: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    view.spacing = 15
    return view
  }()
  
  // MARK: - Lifecycle
  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.fetchUpcomingMovies()
    viewModel.fetchPopularMovies()
    viewModel.fetchNowPlayingMovies()
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()
    configureConstraints()
    observeValues()
  }
  // MARK: - Helpers
  
  private func reusableTitleLabel(text: String) -> UILabel {
    let label = UILabel()
    label.text = text
    label.textColor = UIColor.label
    label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }
  
  private func reusableCollectionView(identifier: String) -> UICollectionView {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 103, height: 157)
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.isSkeletonable = true
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
    collectionView.showsHorizontalScrollIndicator = false
    return collectionView
  }
  
  private func loadAll() {
    imgFeatured.showAnimatedGradientSkeleton()
    colPopular.showAnimatedGradientSkeleton()
    colUpcoming.showAnimatedGradientSkeleton()
    
    guard let posterPath = viewModel.nowPlayingMovies.value.first?.backdropPath,
          let url = URL(string: API.baseUrlImage + posterPath)
    else { return }
    imgFeatured.kf.setImage(with: url) { [weak self] result in
      switch result {
      case .success:
        self?.imgFeatured.hideSkeleton()
        self?.colPopular.hideSkeleton(reloadDataAfter: true)
        self?.colUpcoming.hideSkeleton(reloadDataAfter: true)
      case .failure(let error):
        print("Failed to load image: \(error.localizedDescription)")
      }
    }
  }
  
  private func observeValues() {
    Driver.combineLatest(
      viewModel.upcomingMovies.asDriver(),
      viewModel.popularMovie.asDriver(),
      viewModel.nowPlayingMovies.asDriver()
    ).drive(onNext: { [weak self] upComing, popular, nowPlaying in
      if !upComing.isEmpty && !popular.isEmpty && !nowPlaying.isEmpty {
        self?.loadAll()
      }
    }).disposed(by: disposeBag)
  }
  
  
  private func configureViews() {
    view.backgroundColor = .systemBackground
    title = "Home"
    self.navigationController?.navigationBar.prefersLargeTitles = true
    
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    contentView.addArrangedSubview(stckAppBar)
    contentView.addArrangedSubview(imgFeatured)
    contentView.addArrangedSubview(lblPopular)
    contentView.addArrangedSubview(colPopular)
    contentView.addArrangedSubview(lblUpcoming)
    contentView.addArrangedSubview(colUpcoming)
  }
  
  private func configureConstraints() {
    let safeArea = view.safeAreaLayoutGuide
    
    scrollView.snp.makeConstraints { make in
      make.top.left.bottom.right.equalTo(safeArea)
    }
    
    contentView.snp.makeConstraints { make in
      make.top.left.bottom.right.equalTo(scrollView)
      make.width.equalTo(view.snp.width)
    }
    
    imgFeatured.snp.makeConstraints { make in
      make.height.equalTo(260)
      make.width.equalTo(contentView.snp.width)
    }
    
    lblPopular.snp.makeConstraints { make in
      make.leading.equalTo(contentView).offset(10)
    }
    
    colPopular.snp.makeConstraints { make in
      make.leading.trailing.equalTo(contentView).inset(10)
      make.height.equalTo(157)
    }
    
    lblUpcoming.snp.makeConstraints { make in
      make.leading.equalTo(contentView).offset(10)
    }
    
    colUpcoming.snp.makeConstraints { make in
      make.leading.trailing.equalTo(contentView).inset(10)
      make.height.equalTo(157)
    }
  }
}

// MARK: - SkeletonCollectionViewDataSource

extension HomeViewController: SkeletonCollectionViewDataSource, SkeletonCollectionViewDelegate {
  public func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
    if skeletonView == colPopular {
      return "cell1"
    } else if skeletonView == colUpcoming {
      return "cell2"
    }
    return ""
  }
  
  public func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if skeletonView == colPopular {
      return viewModel.popularMovie.value.count
    } else if skeletonView == colUpcoming {
      return viewModel.upcomingMovies.value.count
    }
    return 0
  }
  // MARK: - UICollectionViewDataSource
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == colPopular {
      return viewModel.popularMovie.value.count
    } else if collectionView == colUpcoming {
      return viewModel.upcomingMovies.value.count
    }
    return 0
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == colPopular {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! MovieCollectionViewCell
      cell.item = viewModel.popularMovie.value[indexPath.row]
      return cell
    } else if collectionView == colUpcoming {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! MovieCollectionViewCell
      cell.item = viewModel.upcomingMovies.value[indexPath.row]
      return cell
    }
    return UICollectionViewCell()
  }
}
// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    var selectedMovieId: Int?
    
    if collectionView == colPopular {
      selectedMovieId = viewModel.popularMovie.value[indexPath.row].id
    } else if collectionView == colUpcoming {
      selectedMovieId = viewModel.upcomingMovies.value[indexPath.row].id
    }
    
//    guard let movieId = selectedMovieId else { return }
//    let detailVC = Injection().container.resolve(DetailViewController.self)!
//    detailVC.movieId = movieId
//    detailVC.hidesBottomBarWhenPushed = true
//    navigationController?.pushViewController(detailVC, animated: true)
  }
}
