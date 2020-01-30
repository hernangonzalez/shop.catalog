//
//  FavouritesView.swift
//  Shopping
//
//  Created by Hernan G. Gonzalez on 26/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import SwiftUI

struct FavouritesView: View {
    @ObservedObject var viewModel: FavouritesViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items) {
                    Text($0.name)
                        .bold()
                }
            }
            .navigationBarTitle(viewModel.title)
        }
        .tabItem {
            Image(systemName: "heart.fill")
            Text(viewModel.title)
        }
    }
}
