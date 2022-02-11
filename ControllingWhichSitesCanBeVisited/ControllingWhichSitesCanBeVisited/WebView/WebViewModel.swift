//
//  WebViewModel.swift
//  ControllingWhichSitesCanBeVisited
//
//  Created by Mika Urakawa on 2022/02/11.
//

import Foundation

class WebViewModel: ObservableObject {
    @Published var needsGoBack = false
    @Published var needsGoForward = false
    @Published var isShownAlert = false

    func goBack() {
        needsGoBack = true
    }

    func goForward() {
        needsGoForward = true
    }
}
