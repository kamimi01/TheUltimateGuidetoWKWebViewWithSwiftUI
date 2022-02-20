//
//  WebView.swift
//  ReadingAWebPagesTitleAsItChanges
//
//  Created by Mika Urakawa on 2022/02/20.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    @Binding var title: String

    private let webView = WKWebView()

    func makeUIView(context: Context) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

extension WebView {
    // didFinishメソッドを使用しない場合は、WKNavigationDelegateへの準拠は不要
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        var observations: [NSKeyValueObservation?] = []

        init(_ parent: WebView) {
            self.parent = parent

            // タイトルが取得でき次第、NavigationBarのタイトルに反映する（こちらの方が反映が早い）
            let titleObservation = parent.webView.observe(\.title, options: .new, changeHandler: { _, value in
                parent.title = (value.newValue ?? "") ?? ""
                print("observation：", (value.newValue ?? "") ?? "")
            })
            observations = [titleObservation]
        }

          // 読み込み完了時に呼ばれ、NavigationBarのタイトルに反映する
//        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            parent.title = webView.title ?? ""
//            print("didFinish：", webView.title)
//        }
    }
}
