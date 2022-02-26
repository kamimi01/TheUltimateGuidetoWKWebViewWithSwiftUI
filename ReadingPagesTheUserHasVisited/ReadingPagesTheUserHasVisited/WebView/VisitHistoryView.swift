//
//  VisitHistoryView.swift
//  ReadingPagesTheUserHasVisited
//
//  Created by Mika Urakawa on 2022/02/26.
//

import SwiftUI
import WebKit

struct VisitHistoryView: View {
    @Binding var isShownVisitHistory: Bool
    var visitedList: [WKBackForwardListItem]
    @Binding var selectedLink: URL?
    @Binding var shouldUpdateWebView: Bool

    var body: some View {
        NavigationView {
            List(visitedList, id: \.self) { list in
                listButton(title: list.title, url: list.url)
            }
                .listStyle(.plain)
                .navigationBarTitle("履歴", displayMode: .inline)
                .navigationBarItems(trailing: doneButton)
        }
    }
}

private extension VisitHistoryView {
    func listButton(title: String?, url: URL) -> some View {
        Button(action: {
            selectedLink = url
            isShownVisitHistory = false
            shouldUpdateWebView = true
        }) {
            VStack(alignment: .leading) {
                Text(title ?? "")
                    .lineLimit(1)
                Text(url.absoluteString)
                    .lineLimit(1)
                    .foregroundColor(.gray)
            }
        }
    }

    var doneButton: some View {
        Button(action: {
            isShownVisitHistory = false
        }) {
            Text("完了")
        }
    }
}

struct VisitHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        VisitHistoryView(
            isShownVisitHistory: .constant(false),
            visitedList: [WKBackForwardListItem](),
            selectedLink: .constant(URL(string: "")!),
            shouldUpdateWebView: .constant(false)
        )
    }
}
