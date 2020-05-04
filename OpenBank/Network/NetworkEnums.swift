//
//  NetworkEnums.swift
//  OpenBank
//
//  Created by Juan Carlos Perez on 1/05/20.
//  Copyright © 2020 Juan Carlos Perez. All rights reserved.
//

import UIKit

enum Environment {
    case develop
    case production
}

enum HostUrl: String {
    case serverProd = "​​https://gateway.marvel.com/"
    case serverDev = "​​https://developer.marvel.com/docs"
}

enum EnpointUrl: String {
    case characters = "v1/public/characters"
    case characterDetail = "v1/public/characters/"
}

enum WSResult<T> {
    case success(T)
    case failure(NetworkingError)
}

enum NetworkingError {
    case domainError(description: String, errorCode: Int)
    case invalidResponse
    case invalidJSON
    
    case serverTimeOut
    
    case invalidOrUnrecognizedParameter
    case characteNoFound
}

    /*
    //Error codes:
*    404 - Character not found.
 
    409    Limit greater than 100.
    409    Limit invalid or below 1.
    409    Invalid or unrecognized parameter.
    409    Empty parameter.
*   409    Invalid or unrecognized ordering parameter.
    409    Too many values sent to a multi-value list filter.
    409    Invalid value passed to filter.
    */

extension NetworkingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .serverTimeOut:
            return "Comunications error."
        case .invalidJSON:
            return "Error parsing result."
        case .invalidResponse:
            return "Unknown error."
        case .domainError(description: let description, errorCode: let errorCode):
            print("Error code \(errorCode)")
            return description
        case .invalidOrUnrecognizedParameter:
            return " Invalid or unrecognized parameter."
        case .characteNoFound:
            return "Character not found."
        }
    }
}

extension NetworkingError: Equatable {
    
}

func ==(lhs: NetworkingError, rhs: NetworkingError) -> Bool {
    switch (lhs, rhs) {
    case (let .domainError(descriptionA, errorCodeA), let .domainError(descriptionB, errorCodeB)):
        return descriptionA == descriptionB && errorCodeA == errorCodeB
        
    case (.characteNoFound, .characteNoFound):
        return true

    default:
        return false
    }
}
