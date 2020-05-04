//
//  CharacterDetailRouter.swift
//  OpenBank
//
//  Created by Juan Carlos Perez on 3/05/20.
//  Copyright (c) 2020 Juan Carlos Perez. All rights reserved.

import UIKit

@objc protocol CharacterDetailRoutingLogic { }

protocol CharacterDetailDataPassing
{
  var dataStore: CharacterDetailDataStore? { get }
}

class CharacterDetailRouter: NSObject, CharacterDetailRoutingLogic, CharacterDetailDataPassing
{
  weak var viewController: CharacterDetailViewController?
  var dataStore: CharacterDetailDataStore?
  
  // MARK: Routing
}
