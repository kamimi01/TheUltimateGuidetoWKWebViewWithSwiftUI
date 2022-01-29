//
//  ContentView.swift
//  MakingAWebviewFillTheScreen
//
//  Created by Mika Urakawa on 2022/01/29.
//

import SwiftUI

struct ContentView: View {
    private let url = "https://www.apple.com"
    
    var body: some View {
        WebView(url: url)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
