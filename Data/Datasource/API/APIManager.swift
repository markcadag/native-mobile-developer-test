//
//  APIManager.swift
//  AppListing
//
//  Created by Mark Anthony Cadag on 10/1/23.
//

import Foundation
import Combine

class APIManager<T> where T: Encodable, T: Decodable {
    let baseURL = "https://dummyapi.io"
    let apiPath = "/data/v1"
   
    func post(_ item: T, path: String) -> AnyPublisher<T, Error> {
        
        guard let url = "\(baseURL)\(path)".toURL() else {
            return Fail(error: NetworkError.apiError("Invalid URL"))
                .eraseToAnyPublisher()
        }
        
        guard let apiKey: String = ConfigurationManager.getValue(forKey: "API_KEY") else {
            return Fail(error: NetworkError.apiError("Key not found, make sure you add this on the config file"))
                .eraseToAnyPublisher()
        }
    
        var request = URLRequest(url:  url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("api-id", forHTTPHeaderField: apiKey)
        do {
           let jsonBody = try JSONEncoder().encode(item)
           request.httpBody = jsonBody
       } catch { }
        
       return URLSession.shared.dataTaskPublisher(for: request)
       .tryMap { output in
         guard let response = output.response as? HTTPURLResponse, response.statusCode == 201 else {
             throw NetworkError.apiError("POST request failed")
         }
         print(response.statusCode)
         return output.data
       }
       .decode(type: T.self, decoder: JSONDecoder())
       .eraseToAnyPublisher()
    }
    
    func get(path: String, _ queryItems: [URLQueryItem]? = nil) -> AnyPublisher<T, Error> {
      
        var urlComponents = URLComponents(string: "\(baseURL)\(apiPath)" + path)!
        
        // Add query items if provided
        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems
        }

        guard let url = urlComponents.url else {
            return Fail(error: NetworkError.apiError("Invalid URL"))
                .eraseToAnyPublisher()
        }

        guard let apiKey: String = ConfigurationManager.getValue(forKey: "API_KEY") else {
            return Fail(error: NetworkError.apiError("Key not found, make sure you add this on the config file"))
                .eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apiKey, forHTTPHeaderField: "app-id")

        return URLSession.shared.dataTaskPublisher(for: request)
            .print("URLSession")
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw NetworkError.apiError("GET request failed")
                }
                print(response.statusCode)
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

extension String {
    func toURL() -> URL? {
        return URL(string: self)
    }
}
