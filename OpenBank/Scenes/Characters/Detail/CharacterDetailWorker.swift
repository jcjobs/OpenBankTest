//
//  CharacterDetailWorker.swift
//  OpenBank
//
//  Created by Juan Carlos Perez on 3/05/20.
//  Copyright (c) 2020 Juan Carlos Perez. All rights reserved.

import UIKit

class CharacterDetailWorker
{
    func fectchCharacterDetail(request: CBaseRequest, charcacterId: String, completion: @escaping charactersResponse) {
      let networkManager: NetworkManager = NetworkManager()
      networkManager.makeRequest(with: request, and: EnpointUrl.characterDetail.rawValue + charcacterId, completion: completion)
  }
}
