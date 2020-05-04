//
//  OpenBankTests.swift
//  OpenBankTests
//
//  Created by Juan Carlos Perez on 1/05/20.
//  Copyright © 2020 Juan Carlos Perez. All rights reserved.
//

import XCTest
@testable import OpenBank

class OpenBankTests: XCTestCase {

    func testCharactersWorker() {
        let expectation = XCTestExpectation(description: "Get Content Data")
        let request = CBaseRequest(offset: 0, limit: 10)
        CharactersListWorker().fectchCharacters(request: request) { result in
            switch result {
                case .failure(_):
                    XCTFail()
                case .success(let resultResponse):
                    XCTAssertNotNil(resultResponse.data, "No data info.")
                    XCTAssertNotNil(resultResponse.data?.results, "No results info.")
                    expectation.fulfill()
            }
        }
         wait(for: [expectation], timeout: 30.0)
    }
    
    func testCharacterDetailWorker() {
         let expectation = XCTestExpectation(description: "Fail fetching Data")
        CharacterDetailWorker().fectchCharacterDetail(request: CBaseRequest(), charcacterId: "") { result in
             switch result {
                 case .failure(let error):
                    XCTAssertEqual(error, NetworkingError.characteNoFound, "Another error code.")
                    expectation.fulfill()
                 case .success(_):
                    XCTFail()
             }
         }
          wait(for: [expectation], timeout: 30.0)
     }

}
