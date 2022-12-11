//
//  ContentView.swift
//  ShowingCustomUI
//
//  Created by mikaurakawa on 2022/12/11.
//

import SwiftUI

struct ContentView: View {
    private let url = URL(string: "https://kamimi01.github.io/StaticAssetSample/javascript-behaviour.html")!
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        WebView(url: url, showAlert: $showAlert, alertMessage: $alertMessage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
