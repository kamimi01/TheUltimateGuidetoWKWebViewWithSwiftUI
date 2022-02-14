//
//  WebView.swift
//  MonitoringPageLoads
//
//  Created by Mika Urakawa on 2022/02/12.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    enum Action {
        case goBack
        case goForward
        case reload
        case none
    }

    private let webView = WKWebView()

    let url: URL
    @Binding var loadingProgress: Double
    @Binding var isLoading: Bool
    @Binding var action: Action
    @Binding var canGoBack: Bool
    @Binding var canGoforward: Bool
    @Binding var title: String

    func makeUIView(context: Context) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        switch action {
        case .goBack:
            uiView.goBack()
        case .goForward:
            uiView.goForward()
        case .reload:
            uiView.reload()
        case .none:
            break
        }
        action = .none
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    static func dismantleUIView(_ uiView: WKWebView, coordinator: Coordinator) {
//        coordinator.observations.compactMap { $0 }.forEach({ $0.invalidate() })  // invalidate()は不要と判断
        coordinator.observations.removeAll()
    }
}

extension WebView {
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        var observations: [NSKeyValueObservation?] = []  // nullableで保持する

        init(_ parent: WebView) {
            self.parent = parent

            let progressObservation = parent.webView.observe(\.estimatedProgress, options: .new, changeHandler: { _, value in
                parent.loadingProgress = value.newValue ?? 0
            })
            let isLoadingObservation = parent.webView.observe(\.isLoading, options: .new, changeHandler: { _, value in
                parent.isLoading = value.newValue ?? false
            })
            observations = [
                progressObservation,
                isLoadingObservation
            ]
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.canGoBack = webView.canGoBack
            parent.canGoforward = webView.canGoForward
            parent.title = webView.title ?? ""
        }
    }
}
