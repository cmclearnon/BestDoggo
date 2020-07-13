//
//  BreedImageViewModel.swift
//  BestDoggo
//
//  Created by Chris McLearnon on 13/07/2020.
//  Copyright © 2020 chrismclearnon. All rights reserved.
//

import Foundation
import Combine

class BreedImageViewModel: ObservableObject {
    @Published var imageURL: String = ""
    
    private let client: APIClient
    
    private var urlTask: AnyCancellable?
    private var imageTask: AnyCancellable?
    
    init(breed: String, client: APIClient) {
        self.client = client
        urlTask = client.getSingleDogImageURL(for: breed, amount: 1)
            .mapError({ (error) -> APIError in
                return .network(description: "Error fetching image URL")
            })
            .map(\.message)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.imageURL = ""
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] imageURLString in
                    guard let self = self else { return }
                    self.imageURL = imageURLString
            })
    }
}
