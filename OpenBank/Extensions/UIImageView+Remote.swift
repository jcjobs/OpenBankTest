//
//  UIImageView+Remote.swift
//  OpenBank
//
//  Created by Juan Carlos Perez on 5/05/20.
//  Copyright © 2020 Juan Carlos Perez. All rights reserved.
//


import UIKit

enum IdentifierImageType: Int {
    case validImageStatus = 999
    case invalidImageStatus = -1
}

extension UIImageView {
    
    public func fromRemotePath(urlPath: String, defaultImage: String = "", isLayer: Bool = false) {
        
        self.backgroundColor = .black
        
        if self.tag != IdentifierImageType.validImageStatus.rawValue {
            self.setDataToImage(defaultImage: defaultImage)
        }
        
        if self.accessibilityIdentifier == defaultImage {
            if !urlPath.isEmpty {
                if let url = URL(string: urlPath) {
                    let config = URLSessionConfiguration.default
                    
                    let request = URLRequest(url: url)
                    
                    let task = URLSession(configuration: config).dataTask(with: request, completionHandler:
                    { (data: Data?, response: URLResponse?, error: Error?) in
                        
                        DispatchQueue.main.async(execute: {
                            if let _ = error {
                                self.setDataToImage(defaultImage: defaultImage,
                                                    tagPivot: IdentifierImageType.invalidImageStatus.rawValue,
                                                    isLayer: isLayer)
                                return
                            }
                            
                            if let dt = data, let remoteImage = UIImage(data: dt) {
                                self.backgroundColor = .clear
                                self.setDataToImage(image: remoteImage)
                            }
                        })
                    })
                    
                    task.resume()
                }
            }
            
            self.setDataToImage(tagPivot: IdentifierImageType.invalidImageStatus.rawValue)
        }
    }
    
    private func setDataToImage(image: UIImage? = nil, defaultImage: String = "",
                                tagPivot: Int = IdentifierImageType.validImageStatus.rawValue,
                                isLayer: Bool = false, isContext: Bool = false) {
        if tagPivot == IdentifierImageType.validImageStatus.rawValue {
            self.image = nil
            self.accessibilityIdentifier = defaultImage
            self.tag = tagPivot
            
            if isLayer {
                let myLayer = CALayer()
                let myImage = image?.cgImage
                myLayer.frame = self.bounds
                myLayer.contents = myImage
                self.layer.addSublayer(myLayer)
            }
            else {
                self.image = image ?? UIImage(named: defaultImage)
            }
        }
        else {
            self.accessibilityIdentifier = ""
        }
    }

}
