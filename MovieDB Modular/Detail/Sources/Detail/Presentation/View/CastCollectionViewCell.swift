//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 15/05/23.
//

import UIKit
import SnapKit
import Kingfisher
import Shared

class CastCollectionViewCell: UICollectionViewCell {
  
  static let reuseIdentifier = "CastCollectionViewCell"
  
  var item: Cast? {
    didSet {
      setContent()
    }
  }
  // MARK: - Properties
  var prefetchUrl: URL?
  
  private lazy var imgCaster: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 45
    return imageView
  }()
  
  private lazy var lblNameCaster: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.textColor = UIColor.label
    label.numberOfLines = 0
    return label
  }()
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureViews()
    configureConstraint()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imgCaster.image = nil
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  // MARK: - Helpers
  
  private func configureViews() {
    backgroundColor = .systemBackground
    
    contentView.addSubview(imgCaster)
    contentView.addSubview(lblNameCaster)
  }
  
  private func configureConstraint() {
    imgCaster.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.centerX.equalTo(self)
      make.height.width.equalTo(90)
    }
    
    lblNameCaster.snp.makeConstraints { make in
      make.top.equalTo(imgCaster.snp.bottom).offset(5)
      make.centerX.equalTo(imgCaster.snp.centerX)
    }
  }
  
  private func setContent() {
    guard let item = item else { return }
    guard let profilePath = item.profilePath else { return }
    guard let url = URL(string: API.baseUrlImage + profilePath) else { return }
    DispatchQueue.main.async {
      self.imgCaster.setImage(with: url)
      self.lblNameCaster.text = item.name
    }
  }
}
