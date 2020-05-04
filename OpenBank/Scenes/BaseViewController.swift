//
//  BaseViewController.swift
//  OpenBank
//
//  Created by Juan Carlos Perez on 3/05/20.
//  Copyright © 2020 Juan Carlos Perez. All rights reserved.
//

import UIKit

enum Loader: String {
    case loader1
    case loader2
}

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func showAlert(with message: String){
        let alert = UIAlertController(title: "¡Aviso!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //Mark-- Loader animated:
    
    func startAnimating(message: String) {
        let loadingTag = Loader.loader1.hashValue
        let rootViewController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        guard let rootVC = rootViewController else { return }
        
        let isShowing = rootVC.view.subviews.filter{$0.tag == loadingTag}.first == nil ? false : true

        if !isShowing {
            let loadingView = UIView().customActivityIndicator(view: rootViewController!.view, backgroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.5), type: .activity)
            loadingView.tag = loadingTag
            rootViewController?.view.addSubview(loadingView)
        }
          
    }
          
    func stopAnimating() {
        let rootViewController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        guard let rootVC = rootViewController else { return }
        for subview in rootVC.view.subviews {
            if subview.tag == Loader.loader1.hashValue {
                subview.removeFromSuperview()
            }
        }
    }

}
