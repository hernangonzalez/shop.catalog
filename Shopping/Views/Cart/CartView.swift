//
//  CartView.swift
//  Shopping
//
//  Created by Hernan G. Gonzalez on 26/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import SwiftUI

struct CartView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Hello, World!")
            }
        }
        .tabItem {
            Image(systemName: "cart.fill")
            Text("Cart")
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
