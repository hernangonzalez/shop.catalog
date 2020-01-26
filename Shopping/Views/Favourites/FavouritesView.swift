//
//  FavouritesView.swift
//  Shopping
//
//  Created by Hernan G. Gonzalez on 26/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import SwiftUI

struct FavouritesView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Hello, World!")
            }
        }
        .tabItem {
            Image(systemName: "heart.fill")
            Text("Favourites")
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
