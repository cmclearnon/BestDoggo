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
        print(self.viewModel.$dogList)
    }
    
    var body: some View {
        NavigationView {
              List {
                ForEach(viewModel.dogList, id: \.self) { dog in
                  HStack {
                    Text(dog)
                  }
                }
              }
              .onAppear(perform: self.viewModel.fetchDogBreeds)
              .navigationBarTitle("Dogs")
                .navigationBarItems(
                    trailing: NavigationButton(text: "Refresh", tapAction: self.viewModel.fetchDogBreeds))
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

struct BreedsListView_Previews: PreviewProvider {
    static var previews: some View {
        BreedsListView(viewModel: BreedsListViewModel(client: APIClient()))
    }
}
