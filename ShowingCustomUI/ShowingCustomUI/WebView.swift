//
//  WebView.swift
//  ShowingCustomUI
//
//  Created by mikaurakawa on 2022/12/11.
//

import Foundation
import SwiftUI
import UIKit
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    private let webView = WKWebView()
    @Binding var showAlert: Bool
    @Binding var alertMessage: String

    func makeUIView(context: Context) -> WKWebView {
        webView.uiDelegate = context.coordinator
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
    class Coordinator: NSObject, WKUIDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
            let alert = UIAlertController(title: "Hey, Listen!", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))

            if let controller = topMostViewController() {
                controller.present(alert, animated: true)
            }
            completionHandler()
        }

        func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default, handler: { _ in
                completionHandler(true)
            }))
            alert.addAction(.init(title: "キャンセル", style: .cancel, handler: { _ in
                completionHandler(false)
            }))
            if let controller = topMostViewController() {
                controller.present(alert, animated: true)
            }
        }

        func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
            let alert = UIAlertController(title: nil, message: prompt, preferredStyle: .alert)
            alert.addTextField { textField in
                textField.text = defaultText
            }
            alert.addAction(.init(title: "OK", style: .default, handler: { _ in
                completionHandler(alert.textFields?.first?.text)
            }))
            alert.addAction(.init(title: "キャンセル", style: .cancel, handler: { _ in
                completionHandler(nil)
            }))
            if let controller = topMostViewController() {
                controller.present(alert, animated: true)
            }
        }

        /// アクティブな画面のViewControllerを取得する
        private func topMostViewController() -> UIViewController? {
            guard let rootController = keyWindow()?.rootViewController
            else { return nil }
            return topMostViewController(for: rootController)
        }

        /// アクティブなUIWindowを取得する
        private func keyWindow() -> UIWindow? {
            return UIApplication.shared.connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .compactMap { $0 as? UIWindowScene }
                .first?.windows.filter { $0.isKeyWindow }.first
        }

        ///
        private func topMostViewController(for controller: UIViewController) -> UIViewController {
            if let presentedController = controller.presentedViewController {
                return topMostViewController(for: presentedController)
            }
            return controller
        }
    }
}
