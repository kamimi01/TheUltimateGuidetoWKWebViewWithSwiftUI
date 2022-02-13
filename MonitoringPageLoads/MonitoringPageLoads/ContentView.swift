//
//  ContentView.swift
//  MonitoringPageLoads
//
//  Created by Mika Urakawa on 2022/02/12.
//

import SwiftUI

struct ContentView: View {
    private let url = "https://www.apple.com/"
    @State private var loadingProgress: Double = 0.0
    @State private var isLoading = false
    @State private var action: WebView.Action = .none
    @State private var canGoBack = false
    @State private var canGoForward = false
    @State private var title = ""

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    WebView(
                        url: URL(string: url)!,
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
                        canGoForward: $canGoForward
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
