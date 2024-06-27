//
//  MockJSONFetcher.swift
//  NewsApp
//
//  Created by tarek ahmed on 25/06/2024.
//

import Foundation

enum MockJSONFetcher {
    
    static func readJSONFromFile<T: Decodable>(fileName: String, fileType: String) -> T? {
        if let path = Bundle.main.path(forResource: fileName, ofType: fileType) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let user = try JSONDecoder().decode(T.self, from: data)
                return user
            } catch {
                print(error)
            }
        }
        
        print("File Not Found")
        return nil
    }
}
