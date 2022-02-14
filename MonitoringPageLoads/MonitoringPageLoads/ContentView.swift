//
//  ContentView.swift
//  MonitoringPageLoads
//
//  Created by Mika Urakawa on 2022/02/12.
//

import SwiftUI

struct ContentView: View {
    private let url = "https://www.apple.com/"
    @State private var isShownWebView = false

    var body: some View {
        Button(action: {
            if URL(string: url) != nil {
                isShownWebView.toggle()
            }
        }) {
            Text("WebView開く")
        }
        .fullScreenCover(isPresented: $isShownWebView) {
            WebBaseView(url: URL(string: url)!, isShownWebView: $isShownWebView)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
