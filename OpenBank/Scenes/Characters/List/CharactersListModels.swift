//
//  CharactersListModels.swift
//  OpenBank
//
//  Created by Juan Carlos Perez on 1/05/20.
//  Copyright (c) 2020 Juan Carlos Perez. All rights reserved.


import UIKit

enum CharactersList
{
     enum Characters
     {
        struct Response
        {
            let charactersList:[CCharacter]
        }
        
       struct ViewModel
       {
        let charactersList:[CCharacter]
       }
     }
    
    enum Detail
    {
        struct Request {
            let selectedCharacter: CCharacter
        }
    }
    
}
