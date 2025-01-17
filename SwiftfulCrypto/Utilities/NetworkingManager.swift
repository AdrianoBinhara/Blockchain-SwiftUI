//
//  NetworkingManager.swift
//  SwiftfulCrypto
//
//  Created by adriano dlucca on 12/05/24.
//

import Foundation
import Combine
class NetworkingManager{
    
    enum NetworkinError: LocalizedError{
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String?{
            switch self {
                case .badURLResponse(url:let url): return "[🔥] Bad response from URL: \(url)"
                case .unknown: return "[⚠️] Unknown error occured."
            }
        }
    }
    
    static func download(url:URL)-> AnyPublisher<Data,Error>{
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "x-cg-demo-api-key": "CG-iXTj9GSKZ5xATYWt9hm6Pjzi"
        ]
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos:.default))
            .tryMap({try handleURLResponse(output: $0, url: url)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output:URLSession.DataTaskPublisher.Output, url: URL)throws -> Data{
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else{
            throw NetworkinError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>){
        switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error.localizedDescription)
        }
    }
}
