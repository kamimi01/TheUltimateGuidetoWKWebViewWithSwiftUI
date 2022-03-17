//
//  WebView.swift
//  ProvidingACustomUserAgent
//
//  Created by Mika Urakawa on 2022/03/17.
//

import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    let url: URL
    @Binding var hasUserAgent: Bool
    private let webView = WKWebView()

    func makeUIView(context: Context) -> WKWebView {
        let request = URLRequest(url: url)
        if hasUserAgent {
            webView.customUserAgent = "ProvidingACustomUserAgent"
        }
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}

