//
//  File.swift
//  
//
//  Created by Finn Christoffer Kurniawan on 13/05/23.
//

#if canImport(UIKit)
import UIKit
import Kingfisher

public extension UIImageView {
    func setImage(with url: URL) {
        let processor = DownsamplingImageProcessor(size: self.bounds.size) |> RoundCornerImageProcessor(cornerRadius: 0)
        
        let options: KingfisherOptionsInfo = [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ]
        
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: UIImage(named: "placeholderImage"), options: options) { result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
                if let compressedImageData = value.image.jpegData(compressionQuality: 0.5) {
                    self.image = UIImage(data: compressedImageData)
                } else {
                    print("Error: Failed to compress image")
                }
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}

#endif
