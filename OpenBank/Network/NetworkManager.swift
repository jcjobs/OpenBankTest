//
//  NetworkManager.swift
//  OpenBank
//
//  Created by Juan Carlos Perez on 1/05/20.
//  Copyright © 2020 Juan Carlos Perez. All rights reserved.
//

import Foundation
import Alamofire

private struct Constants {
    #if DEBUG
    static let timeoutInterval = 60.0
    #else
    static let timeoutInterval = 60.0
    #endif
    static let urlServer = HostUrl.serverProd.rawValue
}

enum SecretKey: String {
    case publicApiKey = "5d6eeb58aab1b013e83e7ae8fe7daa41"
    case privateApiKey = "95ebede75a5c2028c4ee30d8435213ea6269302a"
}

final class NetworkManager: NSObject {

    // MARK: -
    // MARK: Private variables
    private var environmentType: Environment = .develop

    // MARK: -
    // MARK: Check conectivity status

    func isConnectedToNetwork() -> Bool {
        guard let manager = NetworkReachabilityManager() else { return false }
        return manager.isReachable
    }

    // MARK: -
    // MARK: Request methods

    func makeRequest<T: Decodable, U: Encodable>(with parameters: U,and function:String, completion: @escaping (WSResult<T>) -> Void) {

        //Check Conectivity
        guard self.isConnectedToNetwork() else {
            let description = "Unestable internet connection, try again."
            DispatchQueue.main.async(execute: {
                completion(.failure(NetworkingError.domainError(description: description, errorCode: 503)))
            })
            return
        }

        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        var queryString = ""
        do {
             let jsonEncoder = JSONEncoder()
             let body = try jsonEncoder.encode(parameters.self)
             if let dicParam = try? JSONSerialization.jsonObject(with: body, options: []) as? [String: Any] {
                 print(dicParam)
                 for (key, value) in dicParam {
                    queryString.append(queryString.isEmpty ? "?": "&")
                    queryString.append("\(key)=\(value)")
                }
             }
            
         } catch {
           print(error.localizedDescription)
        }
        
        // URL
        let urlString = "\(Constants.urlServer)\(function)\(queryString)".trimmingCharacters(in: .whitespacesAndNewlines)
        //guard let url = URLComponents(string: urlString), let finalUrl =  url.url else {
        guard let finalUrl = URL(string: urlString) else {
            let description = "Invalid URL"
            DispatchQueue.main.async(execute: {
                completion(.failure(NetworkingError.domainError(description: description, errorCode: 503)))
            })
            return
        }

        // Make request
        var theRequest = URLRequest(url: finalUrl)
        theRequest.timeoutInterval = Constants.timeoutInterval
        theRequest.headers = headers
        theRequest.httpMethod = "GET"

        // Send request
        AF.request(theRequest).validate(statusCode: 200..<300).responseData { (responseData) in
            switch responseData.result {
            case .failure(let afError):
                completion(.failure(self.handleError(afError: afError)))
                
            case .success(let data):
                /*if let result = String(data: data, encoding: .utf8) {
                    print(result)
                }*/
                let decodedResult: WSResult<T> = self.decodeData(data: data)
                completion(decodedResult)
                
            }
        }
    }

}

private extension NetworkManager {
    // MARK: Parsing methods

    // Decodes Data into a DecodableType
    func decodeData<T: Decodable>(data: Data?) -> WSResult<T> {
        guard let validData = data else {
            return .failure(NetworkingError.invalidJSON)
        }

        do {
            let decoded = try JSONDecoder().decode(T.self, from: validData)
            return .success(decoded)
        } catch {
            return .failure(NetworkingError.invalidJSON)
        }
    }
    
    
    // MARK: Error methods
    func handleError(afError: AFError) -> NetworkingError {
        switch afError.responseCode {
        case NSURLErrorTimedOut:
            return .serverTimeOut
        case 404:
            return .characteNoFound
        case 409:
            return .invalidOrUnrecognizedParameter
        default:
            let networError = NetworkingError.domainError(description: afError.errorDescription ?? "",
                                                          errorCode: afError.responseCode ?? 0)
            return networError
        }
    }
}
