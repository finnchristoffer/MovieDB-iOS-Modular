//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 16/05/23.
//

import UIKit
import SnapKit
import Kingfisher
import SkeletonView
import Shared

class SearchCollectionViewCell: UICollectionViewCell {
  
  static let reuseIdentifier = String(describing: SearchCollectionViewCell.self)
  
  var item: Movie? {
    didSet {
      setContent()
    }
  }
  
  // MARK: - Properties
  private lazy var imgMoviePoster: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleToFill
    imageView.layer.cornerRadius = 4
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private lazy var lblTitleMovie: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.numberOfLines = 2
    label.textColor = UIColor.label
    return label
  }()
  
  private lazy var lblReleaseDate: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = UIColor.white
    label.numberOfLines = 1
    return label
  }()
  
  private lazy var btnGenre: UIButton = {
    let button = UIButton(type: .custom)
    button.backgroundColor = .systemYellow
    button.layer.cornerRadius = 5
    button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    button.setTitleColor(.black, for: .normal)
    return button
  }()
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureViews()
    configureConstraints()
    
    isSkeletonable = true
    skeletonCornerRadius = 16
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imgMoviePoster.image = nil
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helpers
  private func configureViews() {
    backgroundColor = .systemBackground
    
    addSubview(btnGenre)
    imgMoviePoster.addSubview(btnGenre)
    addSubview(imgMoviePoster)
    addSubview(lblTitleMovie)
    addSubview(lblReleaseDate)
  }
  
  private func configureConstraints() {
    imgMoviePoster.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalTo(215)
      make.width.equalTo(160)
    }
    
    btnGenre.snp.makeConstraints { make in
      make.leading.bottom.equalTo(imgMoviePoster).inset(8)
    }
    
    lblTitleMovie.snp.makeConstraints { make in
      make.top.equalTo(imgMoviePoster.snp.bottom)
      make.leading.trailing.equalToSuperview()
    }
    
    lblReleaseDate.snp.makeConstraints { make in
      make.top.equalTo(lblTitleMovie.snp.bottom).offset(4)
      make.leading.trailing.bottom.equalToSuperview()
    }
    
    lblReleaseDate.setContentHuggingPriority(.required, for: .vertical)
  }
  
  private func setContent() {
    if let item = item {
      lblTitleMovie.text = item.originalTitle
      
      if let posterPath = item.posterPath, let url = URL(string: API.baseUrlImage + posterPath) {
        DispatchQueue.main.async {
          self.imgMoviePoster.setImage(with: url)
        }
      }
      
      let popularityString = String(format: "%.1f", item.popularity ?? 0.0)
      btnGenre.setTitle(popularityString, for: .normal)
      
      lblReleaseDate.text = item.releaseDate
    }
  }
}

