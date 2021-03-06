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
    var baseURL = "https://complianz.io/wp-content/uploads/2019/03/placeholder-300x202.jpg"
    
    init(viewModel: DogListCardViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                URLImage(URL(string: !self.viewModel.isLoading ? self.viewModel.urlList[0] : baseURL)!,
                         delay: 0.25,
                    placeholder: {
                        ProgressView($0) { progress in
                            LoadingIndicator()
                        }
                }) { proxy in
                    proxy.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text(self.viewModel.breed.capitalizingFirstLetter())
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                    }
                    .layoutPriority(100)
                    Spacer()
                }
                .padding()
                .background(SwiftUI.Color.gray.edgesIgnoringSafeArea(.all))
            }
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .circular)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
            )
            .padding([.top, .horizontal])
        }
    }
}

struct DogListCardView_Previews: PreviewProvider {
    static var previews: some View {
        DogListCardView(viewModel: DogListCardViewModel(breed: "hound", client: APIClient()))
    }
}
