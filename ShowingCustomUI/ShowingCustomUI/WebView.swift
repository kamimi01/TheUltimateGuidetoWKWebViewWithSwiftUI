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
    @EnvironmentObject var dialogManager: DialogManager

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
            self.parent.dialogManager.showAlert = true
            self.parent.dialogManager.alertMessage = message
            self.parent.dialogManager.alertCompletion = completionHandler
        }

        func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
            self.parent.dialogManager.showConfirmAlert = true
            self.parent.dialogManager.confirmMessage = message
            self.parent.dialogManager.confirmCompletion = completionHandler
        }

        func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
            self.parent.dialogManager.showPromptAlert = true
            if let defaultText = defaultText {
                self.parent.dialogManager.promptDefaultText = defaultText
            }
            self.parent.dialogManager.promptMessage = prompt
            self.parent.dialogManager.promptCompletion = completionHandler
        }
    }
}
