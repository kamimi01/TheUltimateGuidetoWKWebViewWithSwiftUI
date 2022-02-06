//
//  ContentView.swift
//  LoadingHTMLFragments
//
//  Created by Mika Urakawa on 2022/02/06.
//

import SwiftUI

struct ContentView: View {
    @State private var isShownWebView = false
    @State private var inputText = ""

    var body: some View {
        VStack {
            TextField("", text: $inputText)
                .border(.yellow)
                .padding()
            Button(action: {
                isShownWebView.toggle()
            }) {
                Text("WebView開く")
            }
        }
        .fullScreenCover(isPresented: $isShownWebView) {
            webBaseView
        }
    }
}

private extension ContentView {
    var webBaseView: some View {
        NavigationView {
            WebView(inputText: inputText)
                .navigationBarItems(leading: closeButton)
        }
    }

    var closeButton: some View {
        Button(action: {
            isShownWebView.toggle()
        }) {
            Text("閉じる")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
