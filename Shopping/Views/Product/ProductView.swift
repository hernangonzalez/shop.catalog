//
//  ProductRowView.swift
//  Shopping
//
//  Created by Hernan G. Gonzalez on 25/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import SwiftUI

struct ProductView: View {
    let viewModel: ProductViewModel

    private var oldPriceHeight: CGFloat {
        viewModel.oldPrice.isEmpty ? 0 : 20
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(viewModel.category)
                .foregroundColor(.secondary)
                .font(.subheadline)

            HStack(spacing: 20) {
                Text(viewModel.name)
                    .font(.title)
                Spacer(minLength: 2)

                VStack(alignment: .trailing) {
                    Text(viewModel.price)
                        .font(.largeTitle)
                        .foregroundColor(.green)

                    Text(viewModel.oldPrice)
                        .font(.callout)
                        .foregroundColor(.red)
                        .frame(height: oldPriceHeight)
                }

                Button(action: viewModel.addToCart) {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32)
                        .foregroundColor(.blue)
                }
            }
        }
        .frame(minHeight: 88)
    }
}


#if DEBUG
struct ProductView_Previews: PreviewProvider {
    static let models = [
        ProductViewModel(id: 33, name: "River Plate!", price: "99.0", oldPrice: "120.0", category: "El más grande, lejos.", available: true),
        ProductViewModel(id: 12, name: "Fine Stripe Short Sleeve Shirt, Green", price: "78.0", oldPrice: "", category: "Quién te conoce?", available: false)
    ]

    static var previews: some View {
        NavigationView {
            List {
                Section(header: Text("Section")) {
                    ForEach(models) {
                        ProductView(viewModel: $0)
                    }
                }
            }
        }
    }
}
#endif
