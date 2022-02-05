//
//  ContentView.swift
//  LoadingRemoteContent
//
//  Created by Mika Urakawa on 2022/02/04.
//

import SwiftUI

struct ContentView: View {
    @State private var inputText = ""
    @State private var isShownWebView = false

    var body: some View {
        VStack {
            TextField("", text: $inputText)
                .border(.yellow)
                .padding()
            Button(action: {
                isShownWebView.toggle()
            }) {
                Text("モーダル開く")
            }
        }
        .fullScreenCover(isPresented: $isShownWebView) {
            WebView(name: inputText)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
