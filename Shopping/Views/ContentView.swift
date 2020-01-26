//
//  ContentView.swift
//  Shopping
//
//  Created by Hernan G. Gonzalez on 26/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let browser: BrowserViewModel

    var body: some View {
        TabView {
            BrowserView(viewModel: browser)
            FavouritesView()
            CartView()
        }
    }
}
