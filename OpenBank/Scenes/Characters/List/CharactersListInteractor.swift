//
//  CharactersListInteractor.swift
//  OpenBank
//
//  Created by Juan Carlos Perez on 1/05/20.
//  Copyright (c) 2020 Juan Carlos Perez. All rights reserved.

import UIKit

protocol CharactersListBusinessLogic
{
    func getInitialCharacters()
    func getCharacters()
    func showDetail(request: CharactersList.Detail.Request)
}

protocol CharactersListDataStore
{
  var characterId: Int { get set }
}

class CharactersListInteractor: CharactersListBusinessLogic, CharactersListDataStore
{
    
    enum GetCharactersError: Error {
        case invalidEmail
        case invalidPassword
        case invalidPhoneNumber
    }
    
    var presenter: CharactersListPresentationLogic?
    var worker: CharactersListWorker?
    
    var charactersList = [CCharacter]()
    var characterId: Int = 0
    
    func getInitialCharacters() {
        charactersList.removeAll()
        getCharacters()
    }
    
    func getCharacters() {
        presenter?.presentLoader()
        
        worker = CharactersListWorker()
        worker?.fectchCharacters(request: CBaseRequest(offset: charactersList.count, limit: 100), completion: { [weak self] result in
            guard let self = self else { return }
            self.presenter?.hideLoader()
            
            switch result {
            case .success(let wresponse):
                //print(wresponse)
                guard let dataResult =  wresponse.data, let characters = dataResult.results else{ return }
                self.charactersList.append(contentsOf: characters)
                let response = CharactersList.Characters.Response(charactersList: self.charactersList)
                self.presenter?.presentCharacters(response: response)
            case .failure(let error):
                print(error)
                self.presenter?.presentMessage(message: error.errorDescription ?? "")
            }
            
        })
    }
    
    func showDetail(request: CharactersList.Detail.Request) {
        characterId = request.selectedCharacter.id
        presenter?.presentCharacterDetail()
        
    }
}
