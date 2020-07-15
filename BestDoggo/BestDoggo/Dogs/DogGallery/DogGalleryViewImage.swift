//
//  DogGalleryViewImage.swift
//  BestDoggo
//
//  Created by Chris McLearnon on 13/07/2020.
//  Copyright © 2020 chrismclearnon. All rights reserved.
//

import SwiftUI
import URLImage

struct DogGalleryViewImage: View {
    var url: String
    var baseURL = "https://images.dog.ceo/breeds/hound-basset/n02088238_9701.jpg"
    
    init(url: String) {
        self.url = url
    }
    var body: some View {
        URLImage(URL(string: url)!, placeholder: {
            ProgressView($0) { progress in
                Image(systemName: "circle")
                    .resizable()
                    .frame(width: 182.5,height:125)
            }
        }) { proxy in
            proxy.image
                .resizable()
                .scaledToFill()
                .frame(width: 182.5,height:125)
                .cornerRadius(10)
        }
    }
}

struct DogGalleryViewImage_Previews: PreviewProvider {
    static var previews: some View {
        DogGalleryViewImage(url: "https://images.dog.ceo/breeds/hound-basset/n02088238_9701.jpg")
    }
}
