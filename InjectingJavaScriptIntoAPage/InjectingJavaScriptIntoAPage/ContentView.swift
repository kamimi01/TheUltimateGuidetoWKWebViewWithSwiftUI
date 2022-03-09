//
//  ContentView.swift
//  InjectingJavaScriptIntoAPage
//
//  Created by Mika Urakawa on 2022/03/09.
//

import SwiftUI

struct ContentView: View {
    private let url = URL(string: "http://localhost:3000/")!
    @State private var isShownWebView = false
    @State private var name = ""
    @State private var email = ""

    var body: some View {
        VStack {
            TextField("name", text: $name)
                .textInputAutocapitalization(.never)
                .frame(width: 200)
                .border(.yellow)
            TextField("email", text: $email)
                .textInputAutocapitalization(.never)
                .frame(width: 200)
                .border(.yellow)
            Button(action: {
                isShownWebView.toggle()
            }) {
                Text("値を送信してWebViewを開く")
            }
        }
        .fullScreenCover(isPresented: $isShownWebView) {
            WebView(url: url, name: name, email: email)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
