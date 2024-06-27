//
//  APIManager.swift
//  NewsApp
//
//  Created by tarek ahmed on 22/06/2024.
//

import Foundation
import Combine


protocol APIManagerProtocol {
    func initRequest<T: Decodable>(with data: RequestProtocol,type: T.Type) -> AnyPublisher<T,Error>
}

class APIManager {
    private var urlSession : URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
}

extension APIManager : APIManagerProtocol {
    
    func initRequest<T: Decodable>(with data: RequestProtocol,type: T.Type) -> AnyPublisher<T,Error> {
        
        do {
            return urlSession.dataTaskPublisher(for: try data.createUrlRequest())
                .mapError { error -> NetworkError in
                    switch error.code {
                    case .badURL , .unsupportedURL :
                        return .invalidURL
                    default :
                        return .invalidServerResponse
                    }
                }
                .map(\.data)
                .decode(type: type, decoder: JSONDecoder())
                .mapError { error -> CustomDecodingError in
                    print(error)
                    if error is DecodingError {
                        return .paringError
                    }
                    return .unknown
                }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
    }
}
