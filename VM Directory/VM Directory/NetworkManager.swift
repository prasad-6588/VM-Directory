//
//  NetworkManager.swift
//  VM Directory
//
//  Created by Prasad on 03/04/22.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchData<T: Decodable>(requestType: String,
                                 requestUrl: String,
                                 completion: @escaping (Result<T,Error>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    
    public init() {}
    
    func fetchData<T: Decodable>(requestType: String,
                                 requestUrl: String,
                                 completion: @escaping (Result<T,Error>) -> Void) {
        guard let url = URL(string: requestUrl) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(Result { try JSONDecoder().decode(T.self, from: data!) })
        }.resume()
    }
}
