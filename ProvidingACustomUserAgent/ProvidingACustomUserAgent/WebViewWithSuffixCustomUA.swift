//
//  WebViewWithSuffixCustomUA.swift
//  ProvidingACustomUserAgent
//
//  Created by Mika Urakawa on 2022/03/17.
//

import WebKit
import SwiftUI

struct WebViewWithSuffixCustomUA: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let request = URLRequest(url: url)
        let config = WKWebViewConfiguration()
        config.applicationNameForUserAgent = "ProvidingACustomUserAgent"
        let webView = WKWebView(frame: .zero, configuration: config)

        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
