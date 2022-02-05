//
//  WebView.swift
//  LoadingRemoteContent
//
//  Created by Mika Urakawa on 2022/02/04.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let name: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = HTMLRequest(parameters: ["name": name]).buildURLRequest()
//        let request = URLRequest(url: URL(string: "https://www.apple.com")!) // URLRequestの中身比較用（実際使ったのは上の方のみ）
        uiView.load(request)
    }
}
