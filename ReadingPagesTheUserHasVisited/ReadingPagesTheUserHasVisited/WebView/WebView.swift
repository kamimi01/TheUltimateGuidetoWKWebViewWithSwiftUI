//
//  WebView.swift
//  ReadingPagesTheUserHasVisited
//
//  Created by Mika Urakawa on 2022/02/23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    enum Action {
        case goBack
        case goForward
        case reload
        case none
    }

    var url: URL?
    @Binding var loadingProcess: Double
    @Binding var isLoading: Bool
    @Binding var action: WebView.Action
    @Binding var canGoBack: Bool
    @Binding var canGoForward: Bool
    @Binding var title: String
    @Binding var backList: [WKBackForwardListItem]
    @Binding var forwardList: [WKBackForwardListItem]
    @Binding var shouldUpdateWebView: Bool

    private let webView = WKWebView()

    func makeUIView(context: Context) -> WKWebView {
        print("make")
        webView.navigationDelegate = context.coordinator
        guard let url = url else {
            return WKWebView()
        }
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

        // ここで止めておかないと無限ループが発生する
        // - seealso: https://swiftui-lab.com/state-changes/
        if !shouldUpdateWebView { return }
        guard let url = url else {
            return
        }
        let request = URLRequest(url: url)
        uiView.load(request)

        DispatchQueue.main.async {
            shouldUpdateWebView = false
        }
    }

    func makeCoordinator() -> Coodinator {
        return Coodinator(self)
    }

    func dismantleUIView(_ uiView: WKWebView, coordinator: Coordinator) {
        coordinator.observations.removeAll()
    }
}

extension WebView {
    class Coodinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        var observations: [NSKeyValueObservation?] = []

        init(_ parent: WebView) {
            self.parent = parent

            let progressObservation = parent.webView.observe(\.estimatedProgress, options: .new, changeHandler: { _, value in
                parent.loadingProcess = value.newValue ?? 0
            })
            let isLoadingObservation = parent.webView.observe(\.isLoading, options: .new, changeHandler: { _, value in
                parent.isLoading = value.newValue ?? false
            })
            let titleObservation = parent.webView.observe(\.title, options: .new, changeHandler: { _, value in
                parent.title = (value.newValue ?? "") ?? ""
            })

            observations = [
                progressObservation,
                isLoadingObservation,
                titleObservation
            ]
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.canGoBack = webView.canGoBack
            parent.canGoForward = webView.canGoForward

            parent.backList = webView.backForwardList.backList
            parent.forwardList = webView.backForwardList.forwardList
        }
    }
}
