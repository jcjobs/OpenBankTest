//
//  CharacterDetailViewController.swift
//  OpenBank
//
//  Created by Juan Carlos Perez on 3/05/20.
//  Copyright (c) 2020 Juan Carlos Perez. All rights reserved.

import UIKit
import WebBrowser

protocol CharacterDetailDisplayLogic: class
{
  func displayCharacterDetail(viewModel: CharacterDetail.Detail.ViewModel)
     func dysplayLoader(display: Bool)
    func displayMessage(message: String)
}

class CharacterDetailViewController: BaseViewController
{
    
    @IBOutlet weak var lblCharacter: UILabel!
    @IBOutlet weak var tblCharacterDetail: UITableView!
    
    private var selectedCharacter: Character?
    
  var interactor: CharacterDetailBusinessLogic?
  var router: (NSObjectProtocol & CharacterDetailRoutingLogic & CharacterDetailDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = CharacterDetailInteractor()
    let presenter = CharacterDetailPresenter()
    let router = CharacterDetailRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    setupUI()
    getCharacterDetail()
  }
  
    func getCharacterDetail(){
        interactor?.getCharacterDetail()
    }

}

private extension CharacterDetailViewController {
    func setupUI() {
        tblCharacterDetail.dataSource = self
        tblCharacterDetail.delegate = self
        tblCharacterDetail.alwaysBounceVertical = false
        tblCharacterDetail.rowHeight = UITableView.automaticDimension
        tblCharacterDetail.estimatedRowHeight = 60
    }
    
    func showUrlDetail(){
        let webBrowserViewController = WebBrowserViewController()
        webBrowserViewController.language = .english
        webBrowserViewController.tintColor = .red
        webBrowserViewController.barTintColor = .white
        webBrowserViewController.isToolbarHidden = false
        webBrowserViewController.isShowActionBarButton = true
        webBrowserViewController.toolbarItemSpace = 50
        webBrowserViewController.isShowURLInNavigationBarWhenLoading = true
        webBrowserViewController.isShowPageTitleInNavigationBar = true

        let urlString = selectedCharacter?.urlDetail ?? ""
        webBrowserViewController.loadURLString(urlString.replacingOccurrences(of: "http", with: "https"))
        self.navigationController?.pushViewController(webBrowserViewController, animated: true)
    }
}

extension CharacterDetailViewController: CharacterDetailDisplayLogic {
    func displayCharacterDetail(viewModel: CharacterDetail.Detail.ViewModel) {
        selectedCharacter = viewModel.character
        
        //lblCharacter.text = selectedCharacter?.name ?? ""
        tblCharacterDetail.reloadData()
    }
    
    func dysplayLoader(display: Bool) {
        if display {
            startAnimating(message: "")
        } else {
            stopAnimating()
        }
    }
    
    func displayMessage(message: String) {
        showAlert(with: message)
    }
}

extension CharacterDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = selectedCharacter else {
            return 0
        }
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterDetailTableViewCell.identifier, for: indexPath) as! CharacterDetailTableViewCell
        switch indexPath.row {
        case 0:
            cell.configure(with: "Name:", detail: selectedCharacter?.name ?? "No info")
        case 1:
            cell.configure(with: "Description:", detail: selectedCharacter?.detail ?? "No info")
        case 2:
            var dateString: String?
            if let dateUpdated = selectedCharacter?.dateUpdated {
                let formatter1 = DateFormatter()
                formatter1.dateStyle = .full
                dateString = formatter1.string(from: dateUpdated)
            }
            cell.configure(with: "Updated:", detail:dateString ?? "No info")
        case 3:
            cell.configure(with: "Url:", detail: selectedCharacter?.urlDetail ?? "No info")
        default:
             cell.configure(with: "No info", detail: "No info")
        }
        
        return cell
    }
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    */
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.item == 3, let _ = selectedCharacter?.urlDetail else { return }
        showUrlDetail()
    }
    
}
