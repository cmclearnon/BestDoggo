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
    
    init(url: String) {
        self.url = url
    }
    var body: some View {
        URLImage(URL(string: url)!, placeholder: {
            ProgressView($0) { progress in
                ZStack {
                    if progress > 0.0 {
                        CircleProgressView(progress).stroke(lineWidth: 8.0)
                    }
                    else {
                        CircleActivityView().stroke(lineWidth: 50.0)
                    }
                }
            }.frame(width: 50.0, height: 50.0)
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
        DogGalleryViewImage(url: "")
    }
}
