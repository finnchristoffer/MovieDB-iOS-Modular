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
        let options: KingfisherOptionsInfo = [.processor(ResizingImageProcessor(referenceSize: self.bounds.size, mode: .aspectFill)), .scaleFactor(UIScreen.main.scale), .cacheOriginalImage, .transition(.fade(0.3))]
        self.kf.setImage(with: url, placeholder: nil, options: options, completionHandler: { result in
            switch result {
            case .success(let value):
                if let compressedImageData = value.image.jpegData(compressionQuality: 0.5) {
                    self.image = UIImage(data: compressedImageData)
                } else {
                    print("Error: Queque to compress image")
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        })
    }
}
#endif
