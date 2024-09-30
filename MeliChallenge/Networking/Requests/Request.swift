//
//  Request.swift
//  MeliChallenge
//
//  Created by Yared Nicolas Toro C on 29/09/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case update = "UPDATE"
    case delete = "DELETE"
}

protocol Request {
    associatedtype Output
    var url: URL { get }
    var parameters: Encodable? { get }
    var method: HTTPMethod { get }
    func decode(_ data: Data) throws -> Output
}

extension Request where Output: Decodable {
    
    func decode(_ data: Data) throws -> Output {
        let decoder = JSONDecoder()
        return try decoder.decode(Output.self, from: data)
    }
}

extension Request {
    
    var parameters: Encodable? { nil }
    
    var urlRequest: URLRequest {
        var urlRequest: URLRequest
        
        guard let parameters else {
            urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.rawValue
            return urlRequest
        }
        
        if method == .get, var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            urlComponents.queryItems = parameters.asDictionary().compactMap({ URLQueryItem(name: $0.key, value: $0.value as? String)} )
            urlRequest = URLRequest(url: urlComponents.url!)
        } else {
            urlRequest = URLRequest(url: url)
            urlRequest.httpBody = parameters.encode()
        }
        
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
