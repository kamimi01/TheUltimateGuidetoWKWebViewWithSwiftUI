//
//  WebView.swift
//  InjectingJavaScriptIntoAPage
//
//  Created by Mika Urakawa on 2022/03/09.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    let name: String
    let email: String
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
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            let parameters = ["name": parent.name, "email": parent.email]
            guard let jsonString = createJsonForJavaScript(for: parameters) else {
                return
            }
            let jsString = "fillDetails('\(jsonString)')"

            parent.webView.evaluateJavaScript(jsString) { value, error in
                print(value)  // 「executed　javascript method」が表示される
                print(error?.localizedDescription)  // 成功した場合は、nilになる
            }
        }

        private func createJsonForJavaScript(for data: [String: Any]) -> String? {
            var jsonString: String?

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                jsonString = String(data: jsonData, encoding: .utf8)

                jsonString = jsonString?.replacingOccurrences(of: "\n", with: "")
            } catch {
                print(error.localizedDescription)
            }

            print(jsonString)

            return jsonString
        }
    }
}
