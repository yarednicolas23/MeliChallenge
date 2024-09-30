//
//  Networking.swift
//  MeliChallenge
//
//  Created by Yared Nicolas Toro C on 29/09/24.
//

import Foundation
import Combine
import os.log

protocol Networking {
    func fetch<R: Request>(_ request: R) -> AnyPublisher<R.Output, CustomError>
}

class Networker: Networking {
        
    lazy private var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        URLCache.shared.diskCapacity = Int.max
        return URLSession(configuration: configuration)
    }()
    
    func fetch<R: Request>(_ request: R) -> AnyPublisher<R.Output, CustomError> {
        os_log("[Networker] fetch request called", log: OSLog.network, type: .info)
        return session
            .dataTaskPublisher(for: request.urlRequest)
            .subscribe(on: OperationQueue())
            .receive(on: DispatchQueue.main)
            .compactMap { $0.data }
            .tryMap(request.decode)
            .mapError { error in
                switch error {
                case let urlError where (urlError as? URLError)?.code == .networkConnectionLost:
                    os_log("[Networker] networkConnectionLost:", log: OSLog.network, type: .error)
                    return CustomError.networkConnectionLost
                case let urlError where (urlError as? URLError)?.code == .notConnectedToInternet:
                    os_log("[Networker] notConnectedToInternet:", log: OSLog.network, type: .error)
                    return CustomError.notConnectedToInternet
                case let decodingError where (decodingError as? DecodingError) != nil:
                    os_log("[Networker] decodingError:", log: OSLog.network, type: .error)
                    return CustomError.decodingError
                default:
                    os_log("[Networker] generalError:", log: OSLog.network, type: .error)
                    return CustomError.generalError
                }
            }
            .eraseToAnyPublisher()
    }
}

enum CustomError: Error {
    case networkConnectionLost
    case notConnectedToInternet
    case decodingError
    case generalError
}
