//
//  BreedsListView.swift
//  BestDoggo
//
//  Created by Chris McLearnon on 11/07/2020.
//  Copyright © 2020 chrismclearnon. All rights reserved.
//

import SwiftUI

struct BreedsListView: View {
    @ObservedObject var viewModel: BreedsListViewModel
    
    init(viewModel: BreedsListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.dogList, id: \.self) { dog in
                if self.viewModel.dogList.isEmpty {
                    self.emptySection
                } else {
                    VStack(spacing: 15) {
                        NavigationLink(destination: DogGalleryView(viewModel: DogGalleryViewModel(breed: dog, client: APIClient()))) {
                            DogListCardView(viewModel: DogListCardViewModel(breed: dog, client: APIClient()))
                        }
                    }
                }
              }
                .id(UUID())
                .navigationBarTitle("Dogs")
        }
    }
}

struct NavigationButton: View {
  let text: String
  let tapAction: () -> Void
  
  var body: some View {
    Button(action: tapAction, label: {
      Text(text)
    })
  }
}

private extension BreedsListView {
    var emptySection: some View {
      Section {
        Text("No results")
          .foregroundColor(.gray)
      }
    }
}

struct BreedsListView_Previews: PreviewProvider {
    static var previews: some View {
        BreedsListView(viewModel: BreedsListViewModel(client: APIClient()))
    }
}
