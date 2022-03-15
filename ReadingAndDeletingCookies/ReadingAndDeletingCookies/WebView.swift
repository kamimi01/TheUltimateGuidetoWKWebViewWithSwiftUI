//
//  WebView.swift
//  ReadingAndDeletingCookies
//
//  Created by Mika Urakawa on 2022/03/14.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
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
            let cookieName = "authentication"
            // Cookie取得
            webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
                for cookie in cookies {
                    print("cookie:", cookie.name, "\nvalue:", cookie.value)
                    if cookie.name == cookieName {
                        // UserDefaultsに保存
                        UserDefaults.standard.set(cookie.value, forKey: cookieName)

                        // Cookieを削除（実際はここで削除する意味はないが、cookieの取得と削除の記事を一緒に書きたいという都合上）
                        webView.configuration.websiteDataStore.httpCookieStore.delete(cookie) {
                            print("削除成功")
                        }
                        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
                            print("cookies1:", cookies)
                        }
                        return
                    }
                }
            }
        }
    }
}
