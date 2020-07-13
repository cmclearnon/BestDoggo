//
//  BreedImageView.swift
//  BestDoggo
//
//  Created by Chris McLearnon on 13/07/2020.
//  Copyright © 2020 chrismclearnon. All rights reserved.
//

import SwiftUI

struct BreedImageView: View {
    @ObservedObject var viewModel: BreedImageViewModel
    private var url: URL = URL(string: "https://images.dog.ceo/breeds/hound-basset/n02088238_9701.jpg")!
    
    init(viewModel: BreedImageViewModel) {
        self.viewModel = viewModel
//        self.url = URL(string: self.viewModel.imageURL)!
    }
    
    var body: some View {
        AsyncImage(
            url: self.url,
            placeholder: Text("Loading ...")
        ).aspectRatio(contentMode: .fit)
    }
}

struct BreedImageView_Previews: PreviewProvider {
    static var previews: some View {
        BreedImageView(viewModel: BreedImageViewModel(breed: "hound", client: APIClient()))
    }
}
