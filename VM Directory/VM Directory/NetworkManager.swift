//
//  NetworkManager.swift
//  VM Directory
//
//  Created by Prasad on 03/04/22.
//

import Foundation

struct NetworkManager {
    
    let requestUrl: String
    
    public init(requestUrl: String) {
        self.requestUrl = requestUrl
    }
    
    func fetchData<T: Decodable>(completion: @escaping (Result<T,Error>) -> Void) {
        guard let url = URL(string: requestUrl) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error));
                return
            }
            completion(Result { try JSONDecoder().decode(T.self, from: data!) })
        }.resume()
    }
}
