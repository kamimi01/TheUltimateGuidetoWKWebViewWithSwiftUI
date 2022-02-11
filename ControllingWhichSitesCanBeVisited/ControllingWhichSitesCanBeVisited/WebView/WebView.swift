//
//  WebView.swift
//  ControllingWhichSitesCanBeVisited
//
//  Created by Mika Urakawa on 2022/02/11.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: String
    @ObservedObject var viewModel: WebViewModel

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.navigationDelegate = context.coordinator

        if viewModel.needsGoBack {
            uiView.goBack()
        }
        if viewModel.needsGoForward {
            uiView.goForward()
        }

        guard let url = URL(string: url) else {
            return
        }
        let request = URLRequest(url: url)
        uiView.load(request)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self, viewModel: viewModel)
    }
}

extension WebView {
    class Coordinator: NSObject, WKNavigationDelegate {
        private let parent: WebView
        private let viewModel: WebViewModel

        init(_ parent: WebView, viewModel: WebViewModel) {
            self.parent = parent
            self.viewModel = viewModel
        }

        // decisionHandlerを実行しないケースがあると、クラッシュするので注意
        func webView(
            _ webView: WKWebView,
            decidePolicyFor navigationAction: WKNavigationAction,
            decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
        ) {
            guard let scheme = navigationAction.request.url?.scheme else {
                decisionHandler(.cancel)
                return
            }

            switch scheme {
            case "http", "https":
                // httpまたはhttpsの場合は、表示
                decisionHandler(.allow)
            case "sample-app":
                guard let host = navigationAction.request.url?.host else {
                    decisionHandler(.cancel)
                    return
                }
                // sample-app://alert の場合は、アラートを表示
                if host == "alert" {
                    viewModel.isShownAlert = true
                    decisionHandler(.cancel)
                }
            default:
                decisionHandler(.cancel)
            }
        }
    }
}
