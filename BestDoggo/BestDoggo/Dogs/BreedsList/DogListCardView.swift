//
//  DogListCardView.swift
//  BestDoggo
//
//  Created by Chris McLearnon on 14/07/2020.
//  Copyright © 2020 chrismclearnon. All rights reserved.
//

import SwiftUI
import URLImage

struct DogListCardView: View {
    @ObservedObject var viewModel: DogListCardViewModel
    
//    var url: String?
    
    init(viewModel: DogListCardViewModel) {
        self.viewModel = viewModel
//        self.url = self.viewModel.urlList.first
    }
    
    var body: some View {
        VStack {
            URLImage(URL(string: "https://images.dog.ceo/breeds/hound-basset/n02088238_9701.jpg")!) { proxy in
                proxy.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            HStack {
                VStack(alignment: .leading) {
                    Text(self.viewModel.breed.capitalizingFirstLetter())
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    Text("Sub-breed: \(self.viewModel.breed.capitalizingFirstLetter())".uppercased())
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .layoutPriority(100)
                Spacer()
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .circular)
            .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
        .padding([.top, .horizontal])
    }
}

struct DogListCardView_Previews: PreviewProvider {
    static var previews: some View {
        DogListCardView(viewModel: DogListCardViewModel(breed: "hound", client: APIClient()))
    }
}
