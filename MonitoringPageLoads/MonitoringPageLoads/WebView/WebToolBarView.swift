//
//  WebToolBarView.swift
//  MonitoringPageLoads
//
//  Created by Mika Urakawa on 2022/02/13.
//

import SwiftUI

struct WebToolBarView: View {
    @Binding var action: WebView.Action
    @Binding var canGoBack: Bool
    @Binding var canGoForward: Bool
    @Binding var isShownWebView: Bool

    var body: some View {
        HStack(alignment: .center) {
            goBackButton
            goForwardButton
            reloadButton
            Spacer()
            closeButton
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, minHeight: 50)
        .background(.yellow)
    }
}

private extension WebToolBarView {
    var goBackButton: some View {
        Button(action: {
            action = .goBack
        }) {
            Image(systemName: "chevron.backward")
        }
        .foregroundColor(canGoBack ? .black : .gray)
        .frame(width: 30, height: 30)
        .disabled(!canGoBack)
    }

    var goForwardButton: some View {
        Button(action: {
            action = .goForward
        }) {
            Image(systemName: "chevron.forward")
        }
        .foregroundColor(canGoForward ? .black : .gray)
        .frame(width: 30, height: 30)
        .disabled(!canGoForward)
    }

    var reloadButton: some View {
        Button(action: {
            action = .reload
        }) {
            Image(systemName: "arrow.clockwise")
        }
        .foregroundColor(.black)
        .frame(width: 30, height: 30)
    }

    var closeButton: some View {
        Button(action: {
            isShownWebView.toggle()
        }) {
            Image(systemName: "xmark")
        }
        .foregroundColor(.black)
        .frame(width: 30, height: 30)
    }
}

struct WebToolBarView_Previews: PreviewProvider {
    static var previews: some View {
        WebToolBarView(action: .constant(.none), canGoBack: .constant(false), canGoForward: .constant(false), isShownWebView: .constant(false))
    }
}
