//
//  ContentView.swift
//  ReadingAWebPagesTitleAsItChanges
//
//  Created by Mika Urakawa on 2022/02/20.
//

import SwiftUI

struct ContentView: View {
    private let url = URL(string: "https://www.apple.com/")!
    @State private var title = ""

    var body: some View {
        NavigationView {
            WebView(url: url, title: $title)
                .navigationBarTitle(title, displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
