//
//  ContentView.swift
//  ShowingCustomUI
//
//  Created by mikaurakawa on 2022/12/11.
//

import SwiftUI

struct ContentView: View {
    private let url = URL(string: "https://kamimi01.github.io/StaticAssetSample/javascript-behaviour.html")!
    @EnvironmentObject var dialogManager: DialogManager

    var body: some View {
        WebView(url: url)  // WebViewを表示しようとするとメインスレッドのwarningが出る https://developer.apple.com/forums/thread/712074
//        Text("テスト")  // Textだとwarning出ない
            .environmentObject(dialogManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
