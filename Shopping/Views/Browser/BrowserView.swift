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
                Section(header: Text(viewModel.sectionTitle).bold()) {
                    ForEach(viewModel.products) {
                        Text($0.name)
                    }
                }
            }
            .navigationBarTitle(viewModel.title)
        }
        .onAppear(perform: viewModel.updateProducts)
    }
}

#if DEBUG
struct BrowserView_Previews: PreviewProvider {
    static let model = BrowserViewModel()
    static var previews: some View {
        BrowserView(viewModel: model)
    }
}
#endif
