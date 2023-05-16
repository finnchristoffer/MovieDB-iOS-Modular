//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 15/05/23.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import Kingfisher
import Shared

public class DetailViewController: UIViewController {
  init(viewModel: DetailViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  // MARK: - Properties
  private let viewModel: DetailViewModel
  private var disposeBag = DisposeBag()
  public var movieId: Int?
  
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
  
  private lazy var imgPoster: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private lazy var grdntLayer: CAGradientLayer = {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
    gradientLayer.opacity = 1
    gradientLayer.locations = [0, 1]
    return gradientLayer
  }()
  
  private lazy var lblTitle: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 28)
    label.textColor = UIColor.label
    label.numberOfLines = 1
    label.lineBreakMode = .byTruncatingTail
    return label
  }()
  
  private lazy var lblDuration: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.textColor = UIColor.label
    return label
  }()
  
  private lazy var lblGenre: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.textColor = UIColor.label
    return label
  }()
  
  private lazy var btnWatchTrailer: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "play"), for: .normal)
    button.setTitle(" Watch Trailer", for: .normal)
    button.backgroundColor = UIColor.systemYellow
    button.setTitleColor(UIColor.black, for: .normal)
    button.imageView?.tintColor = UIColor.black
    return button
  }()
  
  private lazy var btnFavorite: UIButton = {
    let button = UIButton()
    button.layer.borderWidth = 1
    button.backgroundColor = UIColor.clear
    button.imageView?.tintColor = UIColor.systemYellow
    button.layer.borderColor = UIColor.white.cgColor
    button.setTitleColor(UIColor.white, for: .normal)
    button.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
    return button
  }()
  
  private lazy var lblMovieOverview: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.label
    label.textAlignment = .justified
    label.numberOfLines = 0
    label.font = UIFont.systemFont(ofSize: 14)
    return label
  }()
  
  private lazy var lblCast: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.text = "Cast"
    label.textColor = UIColor.label
    return label
  }()
  
  private lazy var colCaster: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 110, height: 150)
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.reuseIdentifier)
    collectionView.prefetchDataSource = self
    collectionView.dataSource = self
    collectionView.showsHorizontalScrollIndicator = false
    return collectionView
  }()
  // MARK: - Lifecycle
  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    guard let movieId = movieId else { return }
    viewModel.fetchDetailMovie(id: movieId)
    viewModel.fetchCasterMovie(id: movieId)
    observeFavorite()
    
    navigationItem.largeTitleDisplayMode = .never
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()
    configureConstraints()
    observeValues()
  }
  
  public override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    grdntLayer.frame = imgPoster.bounds
  }
  
  public override func viewWillDisappear(_ animated: Bool) {
    navigationItem.largeTitleDisplayMode = .always
  }
  
  // MARK: - Helpers
  private func configureViews() {
    view.backgroundColor = .systemBackground
    
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    contentView.addArrangedSubview(imgPoster)
    imgPoster.layer.addSublayer(grdntLayer)
    imgPoster.addSubview(lblTitle)
    imgPoster.addSubview(lblDuration)
    imgPoster.addSubview(lblGenre)
    imgPoster.addSubview(btnWatchTrailer)
    imgPoster.addSubview(btnFavorite)
    view.addSubview(btnFavorite)
    contentView.addArrangedSubview(lblMovieOverview)
    contentView.addArrangedSubview(lblCast)
    contentView.addArrangedSubview(colCaster)
  }
  
  private func configureConstraints() {
    let safeArea = view.safeAreaLayoutGuide
    
    scrollView.snp.makeConstraints { make in
      make.top.left.bottom.right.equalTo(safeArea)
    }
    
    contentView.snp.makeConstraints { make in
      make.edges.equalTo(scrollView)
      make.width.equalTo(view.snp.width)
    }
    
    imgPoster.snp.makeConstraints { make in
      make.top.leading.trailing.equalTo(contentView)
      make.width.equalTo(contentView.snp.width)
      make.height.equalTo(560)
    }
    
    lblTitle.snp.makeConstraints { make in
      make.top.equalTo(imgPoster.snp.bottom).offset(-140)
      make.leading.equalTo(imgPoster.snp.leading).offset(15)
      make.trailing.equalTo(imgPoster.snp.trailing).offset(15)
    }
    
    lblDuration.snp.makeConstraints { make in
      make.top.equalTo(lblTitle.snp.bottom).offset(10)
      make.leading.equalTo(imgPoster.snp.leading).offset(15)
    }
    
    lblGenre.snp.makeConstraints { make in
      make.top.equalTo(lblDuration.snp.bottom).offset(10)
      make.leading.equalTo(imgPoster.snp.leading).offset(15)
    }
    
    btnWatchTrailer.snp.makeConstraints { make in
      make.top.equalTo(lblGenre.snp.bottom).offset(10)
      make.leading.equalTo(imgPoster.snp.leading).offset(15)
      make.height.equalTo(36)
      make.width.equalTo(100)
    }
    
    btnFavorite.snp.makeConstraints { make in
      make.top.equalTo(lblGenre.snp.bottom).offset(10)
      make.leading.equalTo(btnWatchTrailer.snp.trailing).offset(15)
      make.trailing.equalTo(contentView.snp.trailing).offset(-15)
      make.height.equalTo(btnWatchTrailer.snp.height)
      make.width.equalTo(btnWatchTrailer.snp.width)
    }
    
    lblMovieOverview.snp.makeConstraints { make in
      make.top.equalTo(imgPoster.snp.bottom).offset(5)
      make.leading.trailing.equalTo(contentView).inset(15)
      
    }
    
    lblCast.snp.makeConstraints { make in
      make.top.equalTo(lblMovieOverview.snp.bottom).offset(15)
      make.leading.equalTo(contentView.snp.leading).offset(15)
    }
    
    colCaster.snp.makeConstraints { make in
      make.top.equalTo(lblCast.snp.bottom).offset(15)
      make.leading.equalTo(contentView.snp.leading).offset(15)
      make.height.equalTo(150)
    }
  }
  
  private func observeValues() {
    viewModel.detailMovie
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] data in
        if data != nil {
          guard let posterPath = data?.posterPath else { return }
          guard let url = URL(string: API.baseUrlImage + posterPath) else { return }
          self?.imgPoster.setImage(with: url)
          
          self?.lblDuration.text = data?.runtime?.minutesToHoursAndMinutes()
          
          let genreNames = data?.genres.compactMap { $0.name }.joined(separator: " • ")
          self?.lblGenre.text = genreNames
          
          self?.lblTitle.text = data?.originalTitle
          self?.lblMovieOverview.text = data?.overview
          
        }
      }).disposed(by: disposeBag)
    
    viewModel.casterMovie
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] data in
        if !data.isEmpty {
          DispatchQueue.main.async {
            self?.colCaster.reloadSections(IndexSet(integer: 0))
          }
        }
      }).disposed(by: disposeBag)
  }
  
  private func observeFavorite() {
    viewModel.checkFavorite(movieId: movieId)
      .subscribe(onNext: { isFavorite in
        self.viewModel.isFavorite.accept(isFavorite)
      }).disposed(by: disposeBag)
    
    viewModel.isFavorite
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] state in
        self?.toggleFavorite(state: state)
      }).disposed(by: disposeBag)
  }
  
  private func toggleFavorite(state: Bool) {
    let btnTitle = state ? " Remove Favorite" : " Add to Favorite"
    btnFavorite.setTitle(btnTitle, for: .normal)
    let btnImageName = state ? "minus" : "plus"
    btnFavorite.setImage(UIImage(systemName: btnImageName), for: .normal)
  }
  
  
  // MARK: - Selectors
  @objc private func didTapFavoriteButton() {
    if viewModel.isFavorite.value {
      viewModel.deleteFromFavorite()
        .subscribe(onNext: { isSucess in
          self.observeFavorite()
        }).disposed(by: disposeBag)
    } else {
      viewModel.insertToFavorite()
        .subscribe(onNext: { isSucess in
          self.observeFavorite()
        }).disposed(by: disposeBag)
    }
  }
}

extension DetailViewController: UICollectionViewDataSource {
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.casterMovie.value.count
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.reuseIdentifier, for: indexPath) as? CastCollectionViewCell else { return UICollectionViewCell()}
    cell.item = viewModel.casterMovie.value[indexPath.row]
    return cell
  }
}

extension DetailViewController: UICollectionViewDataSourcePrefetching {
  public func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    var urlsToPrefetch: [URL] = []
    for indexPath in indexPaths {
      guard let cell = collectionView.cellForItem(at: indexPath) as? CastCollectionViewCell else { continue }
      guard let prefetchUrl = cell.prefetchUrl else { continue }
      urlsToPrefetch.append(prefetchUrl)
    }
    ImagePrefetcher(urls: urlsToPrefetch).start()
  }
}

