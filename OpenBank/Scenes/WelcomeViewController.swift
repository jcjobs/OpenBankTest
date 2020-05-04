//
//  WelcomeViewController.swift
//  OpenBank
//
//  Created by Juan Carlos Perez on 1/05/20.
//  Copyright © 2020 Juan Carlos Perez. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var imvBackground: UIImageView!
    @IBOutlet weak var btnContinue: UIButton!{
        didSet{
            btnContinue.layer.cornerRadius = 10
            btnContinue.layer.borderWidth = 1
            btnContinue.layer.borderColor = UIColor.clear.cgColor
        }
    }
    @IBOutlet weak var lblWelcome: UILabel!
    
    @IBOutlet weak var formTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnContinueBottomConstraint: NSLayoutConstraint!
    private var doneAnimation: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          if !doneAnimation {
              animationStepZero()
          }
          
          navigationController?.navigationBar.isHidden = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
          if !doneAnimation {
              animationStepOne()
              doneAnimation = true
          }
      }

    override func viewDidLayoutSubviews() {
              super.viewDidLayoutSubviews()
       }
       

}
private extension WelcomeViewController {
    // MARK: - Animation
       func animationStepZero() {
         self.imvBackground.image = nil
        
           imvBackground.alpha = 0
           lblWelcome.alpha = 0
           lblWelcome.center = CGPoint(x: view.center.x, y: view.center.y + 40)
           lblWelcome.frame.size = CGSize(width: 265, height: 30)
           lblWelcome.center.y = view.center.y + 60
           
           formTopConstraint.constant = view.frame.height
           btnContinueBottomConstraint.constant -= view.frame.height
           
           view.layoutIfNeeded()
    }
    
    func animationStepOne() {
        UIView.animate(withDuration: 1.0) {
                        self.imvBackground.alpha = 1
        }
        UIView.animate(withDuration: 1.0, animations: {

        }) { (_:Bool) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.animationStepTwo()
            }
        }
    }
    
    func animationStepTwo() {
        UIView.transition(with: self.imvBackground,
                          duration: 0.8,
                          options: .transitionCrossDissolve,
                          animations: { self.imvBackground.image = UIImage(named: "background-image") },
                          completion: nil)
        UIView.animate(withDuration: 0.3) {
            self.lblWelcome.alpha = 1
        }
        UIView.animate(withDuration: 0.8, animations: {
        }) { (_: Bool) in
            self.animationStepThree()
        }
    }
    
    func animationStepThree() {
        UIView.animate(withDuration: 0.8, delay: 0.3, options: [], animations: {
            self.lblWelcome.frame.origin.y = 200
        })
        UIView.animate(withDuration: 0.7, delay: 0.6, options: [], animations: {
            self.formTopConstraint.constant = 80
            self.btnContinueBottomConstraint.constant = 40
            self.view.layoutIfNeeded()
        })
    }
    
}
