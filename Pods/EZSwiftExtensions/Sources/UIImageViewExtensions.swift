//
//  UIImageViewExtensions.swift
//  EZSwiftExtensions
//
//  Created by Goktug Yilmaz on 15/07/15.
//  Copyright (c) 2015 Goktug Yilmaz. All rights reserved.
//

import UIKit

extension UIImageView {
    /// EZSwiftExtensions
    public convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, imageName: String) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        image = UIImage(named: imageName)
    }

    /// EZSwiftExtensions
    public convenience init(x: CGFloat, y: CGFloat, imageName: String, scaleToWidth: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: 0, height: 0))
        image = UIImage(named: imageName)
        if image != nil {
            scaleImageFrameToWidth(width: scaleToWidth)
        } else {
            assertionFailure("EZSwiftExtensions Error: The imageName: '\(imageName)' is invalid!!!")
        }
    }

    /// EZSwiftExtensions
    public convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, image: UIImage) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        self.image = image
    }

    /// EZSwiftExtensions
    public convenience init(x: CGFloat, y: CGFloat, image: UIImage, scaleToWidth: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: 0, height: 0))
        self.image = image
        scaleImageFrameToWidth(width: scaleToWidth)
    }

    /// EZSwiftExtensions, scales this ImageView size to fit the given width
    public func scaleImageFrameToWidth(width: CGFloat) {
        guard let image = image else {
            print("EZSwiftExtensions Error: The image is not set yet!")
            return
        }
        let widthRatio = image.size.width / width
        let newWidth = image.size.width / widthRatio
        let newHeigth = image.size.height / widthRatio
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: newWidth, height: newHeigth)
    }

    /// EZSwiftExtensions, scales this ImageView size to fit the given height
    public func scaleImageFrameToHeight(height: CGFloat) {
        guard let image = image else {
            print("EZSwiftExtensions Error: The image is not set yet!")
            return
        }
        let heightRatio = image.size.height / height
        let newHeight = image.size.height / heightRatio
        let newWidth = image.size.width / heightRatio
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: newWidth, height: newHeight)
    }

    /// EZSwiftExtensions
    public func roundSquareImage() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2
    }

    /// EZSE: Initializes an UIImage from URL and adds into current ImageView
    public func image(url: String) {
        ez.requestImage(url, success: { (image) -> Void in
            if let img = image {
                DispatchQueue.main.async {
                    self.image = img
                }
            }
        })
    }

    /// EZSE: Initializes an UIImage from URL and adds into current ImageView with placeholder
    public func image(url: String, placeholder: UIImage) {
        self.image = placeholder
        image(url: url)
    }

    /// EZSE: Initializes an UIImage from URL and adds into current ImageView with placeholder
    public func image(url: String, placeholderNamed: String) {
        if let image = UIImage(named: placeholderNamed) {
            self.image(url: url, placeholder: image)
        } else {
            image(url: url)
        }
    }

    //MARK: Deprecated 1.8

    /// EZSwiftExtensions
    @available(*, deprecated: 1.8, renamed: "image(url:)")
    public func imageWithUrl(url: String) {
        ez.requestImage(url, success: { (image) -> Void in
            if let img = image {
                DispatchQueue.main.async {
                    self.image = img
                }
            }
        })
    }

    /// EZSwiftExtensions
    @available(*, deprecated: 1.8, renamed: "image(url:placeholder:)")
    public func imageWithUrl(url: String, placeholder: UIImage) {
        self.image = placeholder
        imageWithUrl(url: url)
    }

    /// EZSwiftExtensions
    @available(*, deprecated: 1.8, renamed: "image(url:placeholderNamed:)")
    public func imageWithUrl(url: String, placeholderNamed: String) {
        if let image = UIImage(named: placeholderNamed) {
            imageWithUrl(url: url, placeholder: image)
        } else {
            imageWithUrl(url: url)
        }
    }
}
