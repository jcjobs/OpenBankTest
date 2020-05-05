//
//  CharacterDetailInteractor.swift
//  OpenBank
//
//  Created by Juan Carlos Perez on 3/05/20.
//  Copyright (c) 2020 Juan Carlos Perez. All rights reserved.

import UIKit

protocol CharacterDetailBusinessLogic
{
    func getCharacterDetail()
}

protocol CharacterDetailDataStore
{
  var selectedCharacterId: Int { get set }
}

class CharacterDetailInteractor: CharacterDetailBusinessLogic, CharacterDetailDataStore
{
  var presenter: CharacterDetailPresentationLogic?
  var worker: CharacterDetailWorker?
  var selectedCharacterId: Int = 0
    
    func getCharacterDetail() {
        presenter?.presentLoader()
        
        worker = CharacterDetailWorker()
        worker?.fectchCharacterDetail(request: CBaseRequest(), charcacterId: "\(selectedCharacterId)") { [weak self] result in
            guard let self = self else { return }
            self.presenter?.hideLoader()

            switch result {
            case .success(let wresponse):
              print(wresponse)
              guard let dataResult =  wresponse.data, let character = dataResult.results?.first else{ return }
              
              let characterResult = Character(id: character.id, name: character.name, detail: character.detail, modified: character.modified, urlDetail: character.urls?.first?.url, characterImageUrl: "\(character.thumbnail.path).\(character.thumbnail.imageExtension)")
              
              let response = CharacterDetail.Detail.Response(character: characterResult)
              self.presenter?.presentCharacter(response: response)
            case .failure(let error):
              print(error)
              self.presenter?.presentMessage(message: error.errorDescription ?? "")
            }
        }
    }
    
}


