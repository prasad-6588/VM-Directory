//
//  MockNetworkManager.swift
//  VM Directory
//
//  Created by Prasad on 06/04/22.
//

import Foundation

class MockNetworkManager: NetworkManagerProtocol {
    
    var isApiCalled = false
    
    func fetchData<T>(requestType: String,
                      requestUrl: String,
                      completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        
        isApiCalled = true
        
        let decoder = JSONDecoder()
        guard let pathString = Bundle(for: type(of: self)).path(forResource: requestType, ofType: "json"),
              let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8),
              let jsonData = jsonString.data(using: .utf8) else {
                  let customError = MockNetworkManagerCustomError(title: "Error",
                                                description: "\(requestType).json not found",
                                                code: 999)
                  completion(.failure(customError))
                  return
              }
        completion(Result { try decoder.decode(T.self, from: jsonData) })
    }
}

protocol MockNetworkManagerCustomErrorProtocol: LocalizedError {
    
    var title: String? { get }
    var code: Int { get }
}

struct MockNetworkManagerCustomError: MockNetworkManagerCustomErrorProtocol {
    
    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    
    private var _description: String
    
    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
    }
}
