//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 16/05/23.
//

import UIKit
import SnapKit

public class AccountViewController: UIViewController {
  // MARK: - Properties
  
  private var name: String = ""
  private var about: String = ""
  private var email: String = ""
  private var image: UIImage?
  
  private lazy var imgAvatar: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 100
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private lazy var lblName: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 24)
    label.numberOfLines = 0
    label.textColor = UIColor.label
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var lblEmail: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.attributedText = NSAttributedString(string: email, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    label.textColor = UIColor.label
    return label
  }()
  
  private lazy var lblTitle: UILabel = {
    let label = UILabel()
    label.text = "About"
    label.font = UIFont.boldSystemFont(ofSize: 24)
    label.textColor = UIColor.label
    return label
  }()
  
  private lazy var lblAbout: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    label.numberOfLines = 0
    label.textColor = UIColor.label
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  // MARK: - Lifecycle
  public override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.systemBackground
    configureViews()
    configureConstraints()
  }
  
  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    synchronizeProfile()
    updateUI()
  }
  
  // MARK: - Helpers
  
  private func configureViews() {
    
    view.addSubview(imgAvatar)
    view.addSubview(lblName)
    view.addSubview(lblEmail)
    view.addSubview(lblTitle)
    view.addSubview(lblAbout)
    
    navigationItem.title = "Profile"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  private func configureConstraints() {
    let safeArea = view.safeAreaLayoutGuide
  
    imgAvatar.snp.makeConstraints { make in
      make.centerX.equalTo(safeArea)
      make.top.equalTo(safeArea).offset(15)
      make.width.height.equalTo(200)
    }
    
    lblName.snp.makeConstraints { make in
      make.top.equalTo(imgAvatar.snp.bottom).offset(25)
      make.left.equalTo(safeArea).offset(15)
    }
    
    lblEmail.snp.makeConstraints { make in
      make.top.equalTo(lblName.snp.bottom).offset(7)
      make.left.equalTo(safeArea).offset(15)
    }
    
    lblTitle.snp.makeConstraints { make in
      make.top.equalTo(lblEmail.snp.bottom).offset(40)
      make.left.equalTo(safeArea).offset(15)
    }
    
    lblAbout.snp.makeConstraints { make in
      make.top.equalTo(lblTitle.snp.bottom).offset(7)
      make.left.equalTo(safeArea).offset(15)
    }
  }
  
  private func synchronizeProfile() {
    ProfileModel.synchronize()
    if !ProfileModel.name.isEmpty && !ProfileModel.about.isEmpty && !ProfileModel.email.isEmpty {
      name = ProfileModel.name
      about = ProfileModel.about
      email = ProfileModel.email
      image = UIImage(data: ProfileModel.image)
    } else {
      name = "Finn Christoffer Kurniawan"
      about = "iOS Developer \nApple Developer Academy Graduate"
      email = "finn.christoffer@gmail.com"
    }
  }
  
  private func updateUI() {
    if let image = image {
      imgAvatar.image = image
    } else {
      imgAvatar.image = UIImage(named: "me")
    }
    lblName.text = name
    lblEmail.text = email
    lblAbout.text = about
  }
}

