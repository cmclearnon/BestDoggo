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
        VStack {
            ForEach(0..<self.viewModel.imageURLList.count, id: \.self) { array in
                HStack {
                    ForEach(self.viewModel.imageURLList[array], id: \.self) { url in
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
                }.lineSpacing(15)
            }
        }
    }
}

struct DogGalleryImageRow_Previews: PreviewProvider {
    static var previews: some View {
        DogGalleryImageRow(viewModel: DogGalleryViewModel(breed: "hound", client: APIClient()))
    }
}
