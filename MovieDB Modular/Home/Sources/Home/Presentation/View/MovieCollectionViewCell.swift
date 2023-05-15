//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 14/05/23.
//

import UIKit
import SnapKit
import Kingfisher
import SkeletonView
import Shared

class MovieCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Properties
  
  private lazy var imgMoviePoster: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleToFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  var item: Movie? {
    didSet {
      setContent()
    }
  }
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemBackground
    isSkeletonable = true
    skeletonCornerRadius = 16
    
    configureViews()
    configureConstraint()

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
    contentView.addSubview(imgMoviePoster)
  }
  
  private func configureConstraint() {
    imgMoviePoster.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func setContent() {
    guard let posterPath = item?.posterPath else { return }
    guard let url = URL(string: API.baseUrlImage + posterPath) else { return }
    DispatchQueue.main.async {
      self.imgMoviePoster.setImage(with: url)
    }
  }
}
