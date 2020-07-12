//
//  APIClient.swift
//  BestDoggo
//
//  Created by Chris McLearnon on 09/07/2020.
//  Copyright © 2020 chrismclearnon. All rights reserved.
//

import Foundation
import Combine

protocol APICallable {
    func listAllBreeds() -> AnyPublisher<DogBreedListResp, APIError>
    func randomImages(for breed: String) -> AnyPublisher<DogImagesResp, APIError>
}

class APIClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension APIClient {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
}

extension APIClient: APICallable {
    func listAllBreeds() -> AnyPublisher<DogBreedListResp, APIError> {
        return fetch(with: getAllBreedsURL())
    }
    
    func randomImages(for breed: String) -> AnyPublisher<DogImagesResp, APIError> {
        return fetch(with: getRandomImagesURL(of: breed))
    }
    
    private func fetch<T: Decodable>(with endpoint: URL?) -> AnyPublisher<T, APIError> {
        
        /// Try to safely cast the passed in URL
        /// If fails: Return a network error as a Fail type, then erase its type to AnyPublisher
        guard let url = endpoint else {
            let error = APIError.network(description: "Bad URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        print("URL: \(url)")
        /// URLSession.dataTaskPublisher for fetching Dog API data
        /// Returns either tuple (Data, URLResponse) or URLError
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
            /// Cast error as APIError
            .mapError { error -> APIError in
                return .network(description: "Network error")
            }.flatMap(maxPublishers: .max(1)) { result in
                decode(result.data)
            }

            /// Use eraseToAnyPublisher to erase the return type to AnyPublisher
            /// to prevent leak of implementation details
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

private extension APIClient {
    /// Construction of different Dog API endpoint URLs
    private struct Domains {
        static let baseURL = "https://dog.ceo"
    }

    private struct Routes {
        static let listAllBreeds = "/api/breeds/list/all"
        static let selectedBreed = "/api/breed/"
        static let randomImages = "/images/random/10"
    }

    func getAllBreedsURL() -> URL? {
        let urlString = Domains.baseURL + Routes.listAllBreeds
        let fullURL = URL(string: urlString)
        return fullURL
    }

    func getRandomImagesURL(of breed: String) -> URL? {
        let urlString = Domains.baseURL
                        + Routes.selectedBreed
                        + breed
                        + Routes.randomImages
        let fullURL = URL(string: urlString)
        return fullURL
    }
}
