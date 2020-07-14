//
//  DogGalleryImageRow.swift
//  BestDoggo
//
//  Created by Chris McLearnon on 13/07/2020.
//  Copyright © 2020 chrismclearnon. All rights reserved.
//

import SwiftUI
import URLImage

struct DogGalleryImageRow: View {
    @ObservedObject var viewModel: DogGalleryViewModel
    
    init(viewModel: DogGalleryViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        return ForEach(0..<self.viewModel.imageURLList.count, id: \.self) { array in
            HStack {
                ForEach(self.viewModel.imageURLList[array], id: \.self) { url in
                    URLImage(URL(string: url)!) { proxy in
                        proxy.image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 182.5,height:125)
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}

struct DogGalleryImageRow_Previews: PreviewProvider {
    static var previews: some View {
        DogGalleryImageRow(viewModel: DogGalleryViewModel(breed: "hound", client: APIClient()))
    }
}
