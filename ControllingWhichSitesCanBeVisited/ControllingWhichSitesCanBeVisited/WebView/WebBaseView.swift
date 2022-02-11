//
//  WebBaseView.swift
//  ControllingWhichSitesCanBeVisited
//
//  Created by Mika Urakawa on 2022/02/11.
//

import SwiftUI

struct WebBaseView: View {
    let url: String
    @ObservedObject var viewModel: WebViewModel

    var body: some View {
        VStack(spacing: 0) {
            WebView(url: url, viewModel: viewModel)
            footer
        }
    }
}

private extension WebBaseView {
    var footer: some View {
        HStack(alignment: .center) {
            goBackButton
            goForwardButton
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, minHeight: 50)
        .background(.yellow)
    }

    var goBackButton: some View {
        Button(action: {
            viewModel.goBack()
        }) {
            Image(systemName: "chevron.backward")
        }
        .frame(width: 30, height: 30)
    }

    var goForwardButton: some View {
        Button(action: {
            viewModel.goForward()
        }) {
            Image(systemName: "chevron.forward")
        }
        .frame(width: 30, height: 30)
    }
}

struct WebBaseView_Previews: PreviewProvider {
    static var previews: some View {
        WebBaseView(url: "", viewModel: WebViewModel())
    }
}
