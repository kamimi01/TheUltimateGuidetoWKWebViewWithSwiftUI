//
//  ContentView.swift
//  OpeningALinkInTheExternalBrowser
//
//  Created by Mika Urakawa on 2022/02/11.
//

import SwiftUI

struct ContentView: View {
    private let url = "http://localhost:3000"
    @ObservedObject private var viewModel = WebViewModel()

    var body: some View {
        WebView(url: url, viewModel: viewModel)
            .alert(viewModel.alertTitle, isPresented: $viewModel.isShownAlert) {
                Button(action: {}) {
                    Text("OK")
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
