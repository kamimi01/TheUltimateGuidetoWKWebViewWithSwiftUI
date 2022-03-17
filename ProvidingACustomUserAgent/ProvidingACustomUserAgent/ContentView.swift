//
//  ContentView.swift
//  ProvidingACustomUserAgent
//
//  Created by Mika Urakawa on 2022/03/17.
//

import SwiftUI

struct ContentView: View {
    @State private var isShownWebView = false
    @State private var isShownWebViewWithSuffixCustomUA = false
    @State private var hasUserAgent = false
    private let url = URL(string: "http://localhost:3000/")!

    var body: some View {
        VStack {
            Button(action: {
                hasUserAgent = true
                isShownWebView.toggle()
            }) {
                Text("カスタムUAあり")
            }
            Button(action: {
                hasUserAgent = false
                isShownWebView.toggle()
            }) {
                Text("カスタムUAなし")
            }
            Button(action: {
                isShownWebViewWithSuffixCustomUA.toggle()
            }) {
                Text("SuffixにカスタムUAあり")
            }
        }
        .sheet(isPresented: $isShownWebView) {
            WebView(url: url, hasUserAgent: $hasUserAgent)
        }
        .sheet(isPresented: $isShownWebViewWithSuffixCustomUA) {
            WebViewWithSuffixCustomUA(url: url)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
