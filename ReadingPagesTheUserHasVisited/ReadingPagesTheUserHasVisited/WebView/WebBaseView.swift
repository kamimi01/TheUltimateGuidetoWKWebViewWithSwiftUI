//
//  WebBaseView.swift
//  ReadingPagesTheUserHasVisited
//
//  Created by Mika Urakawa on 2022/02/23.
//

import SwiftUI
import WebKit

struct WebBaseView: View {
    @State private var loadingProgress: Double = 0.0
    @State private var isLoading = false
    @State private var action: WebView.Action = .none
    @State private var canGoBack = false
    @State private var canGoForward = false
    @State private var title = ""
    @Binding var isShownWebView: Bool
    @State private var isShownBackList = false
    @State private var isShownForwardList = false
    @State private var backList = [WKBackForwardListItem]()
    @State private var forwardList = [WKBackForwardListItem]()
    @State private var selectedLink = URL(string: "https://www.apple.com/")
    @State private var shouldUpdateWebView = false

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                WebView(
                    url: selectedLink,
                    loadingProcess: $loadingProgress,
                    isLoading: $isLoading,
                    action: $action,
                    canGoBack: $canGoBack,
                    canGoForward: $canGoForward,
                    title: $title,
                    backList: $backList,
                    forwardList: $forwardList,
                    shouldUpdateWebView: $shouldUpdateWebView
                )
                if isLoading {
                    ProgressView(value: loadingProgress, total: 1.0)
                        .progressViewStyle(.linear)
                        .accentColor(.green)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    goBackButton()
                    goForwardButton()
                    reloadButton
                    Spacer()
                    closeButton
                }
            }
            .navigationBarTitle(title, displayMode: .inline)
        }
    }
}

private extension WebBaseView {
    // FIXME: これだと5回中1回ほどロングタップとワンタップ両方の処理が実行されてしまう
    // - seealso: https://software.small-desk.com/development/2021/09/26/swiftui-howto-longpress-able-button/
//    func goBackButton() -> some View {
//        let longTapGesture = LongPressGesture(minimumDuration: 1.0).onEnded({ _ in
//            print("ロングタップされた1")
//            isShownBackList = true
//        })
//
//        return Button(action: {
//            print("タップされた1")
//            action = .goBack
//        }) {
//            Image(systemName: "chevron.backward")
//        }
//        .foregroundColor(canGoBack ? .black : .gray)
//        .frame(width: 30, height: 30)
//        .simultaneousGesture(longTapGesture)
//        .disabled(!canGoBack)
//        .fullScreenCover(isPresented: $isShownBackList) {
//            VisitHistoryView(
//                isShownVisitHistory: $isShownBackList,
//                visitedList: $backList,
//                tappedLink: $url
//            )
//        }
//    }

    // TODO: 押下時にボタンの色は薄くしたい場合は、Buttonを使用する方法を考えるか、押下中であることを検知して色を変更する処理が必要
    func goBackButton() -> some View {
        let oneTapGesture = TapGesture().onEnded({ _ in
            action = .goBack
        })
        let longTapGesture = LongPressGesture(minimumDuration: 1.0).onEnded({ _ in
            isShownBackList = true
        })

        return Image(systemName: "chevron.backward")
        .foregroundColor(canGoBack ? .black : .gray)
        .frame(width: 30, height: 30)
        .gesture(SimultaneousGesture(oneTapGesture, longTapGesture))
        .disabled(!canGoBack)
        .fullScreenCover(isPresented: $isShownBackList) {
            VisitHistoryView(
                isShownVisitHistory: $isShownBackList,
                visitedList: backList,
                selectedLink: $selectedLink,
                shouldUpdateWebView: $shouldUpdateWebView
            )
        }
    }

    func goForwardButton() -> some View {
        let oneTapGesture = TapGesture().onEnded({ _ in
            action = .goForward
        })
        let longTapGesture = LongPressGesture(minimumDuration: 1.0).onEnded({ _ in
            isShownForwardList = true
        })

        return Image(systemName: "chevron.forward")
        .foregroundColor(canGoForward ? .black : .gray)
        .frame(width: 30, height: 30)
        .gesture(SimultaneousGesture(oneTapGesture, longTapGesture))
        .disabled(!canGoForward)
        .fullScreenCover(isPresented: $isShownForwardList) {
            VisitHistoryView(
                isShownVisitHistory: $isShownForwardList,
                visitedList: forwardList,
                selectedLink: $selectedLink,
                shouldUpdateWebView: $shouldUpdateWebView
            )
        }
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

struct WebBaseView_Previews: PreviewProvider {
    static var previews: some View {
        WebBaseView(isShownWebView: .constant(false))
    }
}
