//
//  ProductRowView.swift
//  Shopping
//
//  Created by Hernan G. Gonzalez on 25/01/2020.
//  Copyright © 2020 HernanGonzalez. All rights reserved.
//

import SwiftUI

struct ProductView: View {
    @ObservedObject var viewModel: ProductViewModel

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

                Image(systemName: "plus.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                    .foregroundColor(viewModel.addState.color)
                    .onTapGesture(perform: viewModel.add)
            }
        }
        .frame(minHeight: 88)
    }
}

private extension ActionState {
    var color: Color {
        switch self {
        case .disabled:
            return .gray
        case .enabled:
            return .blue
        case .inProgress:
            return .yellow
        }
    }
}
