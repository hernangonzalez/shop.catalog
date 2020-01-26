//
//  CartView.swift
//  Shopping
//
//  Created by Hernan G. Gonzalez on 26/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: CartViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items) {
                    Text($0.name).frame(minHeight: 88)
                }
                .onDelete {
                    debugPrint($0)
                }
            }
            .navigationBarTitle(viewModel.title)
        }
        .tabItem {
            Image(systemName: "cart.fill")
            Text(viewModel.title)
        }
    }
}
