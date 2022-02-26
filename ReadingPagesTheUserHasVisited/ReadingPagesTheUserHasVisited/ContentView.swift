//
//  ContentView.swift
//  ReadingPagesTheUserHasVisited
//
//  Created by Mika Urakawa on 2022/02/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isShownWebView = false

    var body: some View {
        Button(action: {
            isShownWebView.toggle()
        }) {
            Text("WebView開く")
                .padding()
        }
        .fullScreenCover(isPresented: $isShownWebView) {
            WebBaseView(isShownWebView: $isShownWebView)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
