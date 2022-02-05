//
//  WebView.swift
//  LoadingLocalContent
//
//  Created by Mika Urakawa on 2022/02/05.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @Binding var assetName: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let fileName = NSString(string: assetName)
        let pathPrefix = fileName.deletingPathExtension
        let pathExtension = fileName.pathExtension
        if pathPrefix.isEmpty || pathExtension.isEmpty {
            return
        }

        if let url = Bundle.main.url(forResource: pathPrefix, withExtension: pathExtension) {
            uiView.loadFileURL(url, allowingReadAccessTo: url)
        }
    }
}
