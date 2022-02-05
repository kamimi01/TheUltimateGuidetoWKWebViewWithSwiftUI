//
//  ContentView.swift
//  LoadingLocalContent
//
//  Created by Mika Urakawa on 2022/02/05.
//

import SwiftUI

struct ContentView: View {
    @State private var isShownLocalAsset = false
    @State private var shownAssetName = ""

    var body: some View {
        VStack {
            Spacer()
            showAssetButton(
                assetName: "index.html",
                title: "HTML開く"
            )
            Spacer()
            showAssetButton(
                assetName: "profile.jpg",
                title: "画像開く"
            )
            Spacer()
        }
        .fullScreenCover(isPresented: $isShownLocalAsset) {
            webBaseView
        }
    }
}

private extension ContentView {
    func showAssetButton(assetName: String, title: String) -> some View {
        Button(action: {
            shownAssetName = assetName
            isShownLocalAsset.toggle()
        }) {
            Text(title)
        }
    }

    var webBaseView: some View {
        NavigationView {
            WebView(assetName: $shownAssetName)
                .navigationBarItems(leading: closeButton)
        }
    }

    var closeButton: some View {
        Button(action: {
            isShownLocalAsset.toggle()
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
