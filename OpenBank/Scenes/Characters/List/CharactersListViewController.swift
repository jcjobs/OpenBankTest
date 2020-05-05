//
//  CharactersListViewController.swift
//  OpenBank
//
//  Created by Juan Carlos Perez on 1/05/20.
//  Copyright (c) 2020 Juan Carlos Perez. All rights reserved.

import UIKit

protocol CharactersListDisplayLogic: class
{
    func displayCharacters(viewModel: CharactersList.Characters.ViewModel)
    func dysplayLoader(display: Bool)
    func displayCharacterDetail()
    func displayMessage(message: String)
}

class CharactersListViewController: BaseViewController
{
    @IBOutlet weak var lblNumberOfResults: UILabel!
    @IBOutlet weak var clvCharacters: UICollectionView!
    private let refreshControl = UIRefreshControl()
    
    var charactersList = [CCharacter]()
    
    var interactor: CharactersListBusinessLogic?
    var router: (NSObjectProtocol & CharactersListRoutingLogic & CharactersListDataPassing)?
    
    private let columnLayout = ColumnFlowLayout(
              cellsPerRow:  2,
              itemHeight: CGFloat(200),
              minimumInteritemSpacing: 16,
              minimumLineSpacing: 16,
              sectionInset: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    )

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
    let interactor = CharactersListInteractor()
    let presenter = CharactersListPresenter()
    let router = CharactersListRouter()
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    
    interactor?.getInitialCharacters()
  }
    
    @IBAction func scrollTop(_ sender: UIButton) {
        clvCharacters.setContentOffset(.zero, animated: true)
    }
 
}

private extension CharactersListViewController {
    
    func setupUI() {
        clvCharacters.dataSource = self
        clvCharacters.delegate = self
        clvCharacters.collectionViewLayout = columnLayout
        clvCharacters.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresCharactersData(_:)), for: .valueChanged)
        
        lblNumberOfResults.text = "Results: 0"
    }
    
    func getCharacters() {
        interactor?.getCharacters()
    }
    
    func showCharacterDetail() {
        performSegue(withIdentifier: "ShowDetail", sender: self)
        //router?.routeToShowDetail(segue: nil)
    }
    
    @objc private func refresCharactersData(_ sender: Any) {
        interactor?.getInitialCharacters()
    }
    
}
extension CharactersListViewController: CharactersListDisplayLogic {
    func displayCharacters(viewModel: CharactersList.Characters.ViewModel) {
        charactersList = viewModel.charactersList
        
        lblNumberOfResults.text = "Results: \(charactersList.count)"
        clvCharacters.reloadData()
    }
    
    func dysplayLoader(display: Bool) {
        if display {
            startAnimating(message: "")
        } else {
            stopAnimating()
            refreshControl.endRefreshing()
        }
    }
    
    func displayCharacterDetail() {
        showCharacterDetail()
    }
    
    func displayMessage(message: String) {
        showAlert(with: message)
    }
    
}

extension CharactersListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return charactersList.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCollectionViewCell.identifier, for: indexPath) as! CharactersCollectionViewCell
        let data = charactersList[indexPath.row]
        cell.configure(with: "\(data.name)", urlString: "\(data.thumbnail.path).\(data.thumbnail.imageExtension)")
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
}

extension CharactersListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCharacter = charactersList[indexPath.item]
        print(selectedCharacter)
        interactor?.showDetail(request: CharactersList.Detail.Request(selectedCharacter: selectedCharacter))
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         if (indexPath.row == charactersList.count - 1 ) {
            interactor?.getCharacters()
         }
    }
    
}

