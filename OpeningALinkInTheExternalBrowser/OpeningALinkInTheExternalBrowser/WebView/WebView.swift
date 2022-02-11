//
//  WebView.swift
//  OpeningALinkInTheExternalBrowser
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

        guard let url = URL(string: url) else {
            return
        }
        let request = URLRequest(url: url)
        uiView.load(request)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }
}

extension WebView {
    class Coordinator: NSObject, WKNavigationDelegate {
        var viewModel: WebViewModel

        init(viewModel: WebViewModel) {
            self.viewModel = viewModel
        }

        // decisionHandlerを実行しないケースがあると、クラッシュするので注意
        func webView(
            _ webView: WKWebView,
            decidePolicyFor navigationAction: WKNavigationAction,
            decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
        ) {
            guard let url = navigationAction.request.url,
                  let scheme = url.scheme
            else {
                decisionHandler(.cancel)
                return
            }

            switch scheme {
            case "http", "https":
                guard let host = url.host else {
                    decisionHandler(.cancel)
                    return
                }
                // ホストがlocalhostのページだけは、アプリで開く
                if host == "localhost" {
                    decisionHandler(.allow)
                    return
                }

                // localhost以外はSafariで開く
                UIApplication.shared.open(url) { [weak self] result in
                    guard let self = self else {
                        decisionHandler(.cancel)
                        return
                    }
                    self.viewModel.alertTitle = "Safariで開いた"
                    self.viewModel.isShownAlert = result
                }
                decisionHandler(.cancel)
            case "sample-app":
                // 自分自身のカスタムURLスキームを指定する
                UIApplication.shared.open(url) { [weak self] result in
                    guard let self = self else {
                        decisionHandler(.cancel)
                        return
                    }
                    self.viewModel.alertTitle = "カスタムURLで自分自身を開いた"
                    self.viewModel.isShownAlert = result
                }
                decisionHandler(.cancel)
            default:
                decisionHandler(.cancel)
            }
        }
    }
}
