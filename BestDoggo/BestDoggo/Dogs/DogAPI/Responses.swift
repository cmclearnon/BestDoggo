//
//  Responses.swift
//  BestDoggo
//
//  Created by Chris McLearnon on 09/07/2020.
//  Copyright © 2020 chrismclearnon. All rights reserved.
//

import Foundation

struct DogBreedListResp: Codable {
    let status: String
    let message: [String: [String]]
}

struct DogImagesResp: Codable {
    let status: String
    let message: [String]
}
