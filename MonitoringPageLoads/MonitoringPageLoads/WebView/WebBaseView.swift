//
//  WebBaseView.swift
//  MonitoringPageLoads
//
//  Created by Mika Urakawa on 2022/02/13.
//

import SwiftUI

struct WebBaseView: View {
    let url: URL
    @State private var loadingProgress: Double = 0.0
    @State private var isLoading = false
    @State private var action: WebView.Action = .none
    @State private var canGoBack = false
    @State private var canGoForward = false
    @State private var title = ""
    @Binding var isShownWebView: Bool

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    WebView(
                        url: url,
                        loadingProgress: $loadingProgress,
                        isLoading: $isLoading,
                        action: $action,
                        canGoBack: $canGoBack,
                        canGoforward: $canGoForward,
                        title: $title
                    )
                    WebToolBarView(
                        action: $action,
                        canGoBack: $canGoBack,
                        canGoForward: $canGoForward,
                        isShownWebView: $isShownWebView
                    )
                }
                if isLoading {
                    ProgressView(value: loadingProgress, total: 1.0)
                        .progressViewStyle(LinearProgressViewStyle())
                        .accentColor(.green)
                }
            }
            .navigationBarTitle(title, displayMode: .inline)
        }
    }
}

struct WebBaseView_Previews: PreviewProvider {
    static var previews: some View {
        WebBaseView(url: URL(string: "")!, isShownWebView: .constant(false))
    }
}
