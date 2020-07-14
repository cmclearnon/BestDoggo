//
//  DogView.swift
//  BestDoggo
//
//  Created by Chris McLearnon on 13/07/2020.
//  Copyright © 2020 chrismclearnon. All rights reserved.
//

import SwiftUI

struct DogGalleryView: View {
    @ObservedObject var viewModel: DogGalleryViewModel
    
    init(viewModel: DogGalleryViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List {
                DogGalleryImageRow(viewModel: DogGalleryViewModel(breed: self.viewModel.breed, client: APIClient()))
            }.navigationBarTitle(Text(self.viewModel.breed.capitalizingFirstLetter()))
                .navigationBarItems(
                    trailing: NavigationButton(text: "Refresh", tapAction: self.viewModel.fetchImageURLs))
        }
    }
}

struct DogGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        DogGalleryView(viewModel: DogGalleryViewModel(breed: "hound", client: APIClient()))
    }
}
