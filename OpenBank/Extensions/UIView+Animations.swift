//
//  UIView+Animations.swift
//  OpenBank
//
//  Created by Juan Carlos Perez on 3/05/20.
//  Copyright © 2020 Juan Carlos Perez. All rights reserved.
//

import UIKit
import Lottie

enum LoaderType : String {
    case activity = "loader1"
    case downloading = "downloading"
    case none
}

extension UIView {
    func customActivityIndicator(view: UIView, widthView: CGFloat? = nil, backgroundColor: UIColor? = nil, message: String? = nil, colorMessage: UIColor? = nil , type: LoaderType = .activity) -> UIView {
        
        self.backgroundColor = backgroundColor ?? UIColor.clear
        
        var selfWidth = view.frame.width
        if widthView != nil {
            selfWidth = widthView ?? selfWidth
        }
        
        let selfHeigh = view.frame.height//CGFloat(100)
        let selfFrameX = (view.frame.width / 2) - (selfWidth / 2)
        let selfFrameY = (view.frame.height / 2) - (selfHeigh / 2)
        
        let animationView = AnimationView.init(name: type.rawValue, bundle: Bundle.main, imageProvider: nil, animationCache: nil)
            animationView.contentMode = .scaleAspectFill
            animationView.loopMode = .loop
            
            var imageWidth = CGFloat(250)
            var imageHeight = CGFloat(150)
            let imageFrameX = (selfWidth / 2) - (imageWidth/2)
            let imageFrameY = (selfHeigh / 2) - (imageHeight/2)
            
            if widthView != nil {
                imageWidth = widthView ?? imageWidth
                imageHeight = widthView ?? imageHeight
            }
            

            self.addSubview(animationView)
            animationView.play { (_) in
                //TODO: Acción cuando termine la ejecución de la animación
            }
            
           
            animationView.frame = CGRect(x: imageFrameX, y: imageFrameY, width: imageWidth, height: imageHeight)
  
        
            self.frame = CGRect(x: selfFrameX, y: selfFrameY, width: selfWidth, height: selfHeigh)
        
        return self
    }
    
}
