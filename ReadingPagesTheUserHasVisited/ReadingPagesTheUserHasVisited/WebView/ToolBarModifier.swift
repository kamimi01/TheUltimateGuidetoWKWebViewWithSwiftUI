//
//  ToolBarModifier.swift
//  ReadingPagesTheUserHasVisited
//
//  Created by Mika Urakawa on 2022/02/26.
//

import SwiftUI

// 実際はこのカスタムview modifierは使っていない
// toolbarの色を変更するために使用したかったが、toolbarの色がclearになってくれなかった
// - seealso: https://stackoverflow.com/questions/64583275/swiftui-how-to-change-navigationview-toolbar-background-color
struct ToolBarModifier: ViewModifier {
    var backgroundColor: UIColor?

    init(backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        // backgroundcolorはclearに統一
        coloredAppearance.backgroundColor = .red

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }

    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                // ここで指定した色のColorを一番上に来るように被せる
                GeometryReader { geometry in
                    Spacer()
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.bottom)
                        .edgesIgnoringSafeArea(.bottom)
                }
            }
        }
    }
}

extension View {
    func toolBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(ToolBarModifier(backgroundColor: backgroundColor))
    }
}
