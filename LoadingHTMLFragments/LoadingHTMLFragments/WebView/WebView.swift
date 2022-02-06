//
//  WebView.swift
//  LoadingHTMLFragments
//
//  Created by Mika Urakawa on 2022/02/06.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let inputText: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let displayedText = inputText.isEmpty ? "nothing" : inputText

        let html = """
        <html>
        <head>
        <link rel="stylesheet" type="text/css" href="index.css">
        </head>
        <body>
        <h1>Hello World!</h1>
        <h2>I am kamimi. I love \(displayedText).</h2>
        </body>
        </html>
        """
        
        guard let urlPath = Bundle.main.path(forResource: "index", ofType: "css") else {
            return
        }
        let url = NSURL.fileURL(withPath: urlPath)
        uiView.loadHTMLString(html, baseURL: url)
    }
}
