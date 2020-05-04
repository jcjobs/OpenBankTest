//
//  CharactersListWorker.swift
//  OpenBank
//
//  Created by Juan Carlos Perez on 1/05/20.
//  Copyright (c) 2020 Juan Carlos Perez. All rights reserved.

import UIKit

typealias charactersResponse = (WSResult<CCharactersResponse>) ->()

class CharactersListWorker
{
    
  func fectchCharacters(request: CBaseRequest, completion: @escaping charactersResponse) {
      let networkManager: NetworkManager = NetworkManager()
      networkManager.makeRequest(with: request, and: EnpointUrl.characters.rawValue, completion: completion)
  }
    
}
