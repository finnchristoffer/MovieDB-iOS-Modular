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

class FavoriteTableViewCell: UITableViewCell {
  
  static let reuseIdentifier = String(describing: FavoriteTableViewCell.self)
  
  var item: MovieObjectEntity? {
    didSet {
      setContent()
    }
  }
  
  // MARK: - Properties
  private lazy var imgMoviePoster: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 4
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private lazy var lblTitleMovie: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.numberOfLines = 2
    label.textColor = UIColor.label
    return label
  }()
  
  private lazy var lblGenreMovie: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = UIColor.secondaryLabel
    label.numberOfLines = 2
    return label
  }()
  
  private lazy var lblReleaseMovie: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = UIColor.secondaryLabel
    label.numberOfLines = 1
    return label
  }()
  // MARK: - Lifecycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)

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
    addSubview(imgMoviePoster)
    addSubview(lblTitleMovie)
    addSubview(lblReleaseMovie)
    addSubview(lblGenreMovie)
  }
  
  private func configureConstraints() {
    imgMoviePoster.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().inset(5)
      make.bottom.equalToSuperview().offset(-15)
      make.height.equalTo(100)
      make.width.equalTo(180)
    }
    
    lblTitleMovie.snp.makeConstraints { make in
      make.left.equalTo(imgMoviePoster.snp.right).offset(10)
      make.top.right.equalToSuperview()
    }
    
    lblReleaseMovie.snp.makeConstraints { make in
      make.top.equalTo(lblTitleMovie.snp.bottom).offset(5)
      make.left.equalTo(imgMoviePoster.snp.right).offset(10)
      make.right.equalToSuperview()
    }
    
    lblGenreMovie.snp.makeConstraints { make in
      make.top.equalTo(lblReleaseMovie.snp.bottom).offset(5)
      make.left.equalTo(imgMoviePoster.snp.right).offset(10)
      make.right.equalToSuperview()
    }
  }
  
  private func setContent() {
    guard let item = item else { return }
    lblTitleMovie.text = item.title
    lblReleaseMovie.text = item.releaseDate
    
    let genreNames = item.genres.compactMap { $0?.name }.joined(separator: ", ")
    lblGenreMovie.text = genreNames
    
    guard let url = URL(string: API.baseUrlImage + item.imageUrl) else { return }
    DispatchQueue.main.async {
      self.imgMoviePoster.setImage(with: url)
    }
  }
}

