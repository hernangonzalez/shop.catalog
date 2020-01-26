//
//  BrowserView.swift
//  Shopping
//
//  Created by Hernan G. Gonzalez on 25/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import SwiftUI

struct BrowserView: View {
    @ObservedObject var viewModel: BrowserViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.products) {
                    ProductView(viewModel: $0)
                }
            }
            .navigationBarTitle(viewModel.title)
        }
        .onAppear(perform: viewModel.updateProducts)
        .tabItem {
            Image(systemName: "list.dash")
            Text(viewModel.title)
        }
    }
}
