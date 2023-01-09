//
//  NetworkingManager.swift
//  CryptoTracker
//
//  Created by Bahadır Sönmez on 21.12.2022.
//

import Combine
import Foundation

final class NetworkingManager {
    
    enum NetworkingResponse {
        case success
        case failure(_ error: NetworkingError)
    }
    
    enum NetworkingError: LocalizedError {
        case authenticationError
        case badRequest
        case outdated
        case failed
        case noData
        case unableToDecode
        
        var errorDescription: String? {
            switch self {
            case .authenticationError: return "You need to be authenticated first."
            case .badRequest: return "Bad request"
            case .outdated: return "The url you requested is outdated."
            case .failed: return "Network request failed."
            case .noData: return "Response returned with no data to decode."
            case .unableToDecode: return "We could not decode the response."
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, any Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        if let response = output.response as? HTTPURLResponse {
            switch handleNetworkResponse(response) {
            case .success:
                return output.data
            case .failure(let error):
                throw error
            }
        } else {
            throw NetworkingError.failed
        }
    }
    
    static func handleCompletion(completion:  Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    static private func handleNetworkResponse(_ response: HTTPURLResponse) -> NetworkingResponse {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(.authenticationError)
        case 501...599: return .failure(.badRequest)
        case 600: return .failure(.outdated)
        default: return .failure(.failed)
        }
    }
}
