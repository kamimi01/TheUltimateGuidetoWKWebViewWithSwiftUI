//
//  ContentView.swift
//  ReadingAndDeletingCookies
//
//  Created by Mika Urakawa on 2022/03/14.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = ContentViewModel()
    private let url = URL(string: "http://localhost:3000")!
    @State private var onLogin = false

    var body: some View {
        VStack {
            Button(action: {
                onLogin.toggle()
            }) {
                Text("ログイン")
            }
            Divider()
                .foregroundColor(.black)
            Button(action: {
                viewModel.getUserInfo()
            }) {
                Text("情報取得")
            }
            Text("取得結果：\n\(viewModel.result)")
        }
        .sheet(isPresented: $onLogin) {
            WebView(url: url)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
