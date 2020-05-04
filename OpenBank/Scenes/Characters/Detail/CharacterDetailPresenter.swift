//
//  CharacterDetailPresenter.swift
//  OpenBank
//
//  Created by Juan Carlos Perez on 3/05/20.
//  Copyright (c) 2020 Juan Carlos Perez. All rights reserved.

import UIKit

protocol CharacterDetailPresentationLogic
{
    func presentCharacter(response: CharacterDetail.Detail.Response)
    
    func presentLoader()
    func hideLoader()
    func presentMessage(message: String)
}

class CharacterDetailPresenter: CharacterDetailPresentationLogic
{
  weak var viewController: CharacterDetailDisplayLogic?
  
  func presentCharacter(response: CharacterDetail.Detail.Response) {
    let viewModel = CharacterDetail.Detail.ViewModel(character: response.character)
    viewController?.displayCharacterDetail(viewModel: viewModel)
  }
    
    
    func presentLoader() {
        viewController?.dysplayLoader(display: true)
    }
    
    func hideLoader() {
        viewController?.dysplayLoader(display: false)
    }
    
    func presentMessage(message: String) {
        viewController?.displayMessage(message: message)
    }
}
