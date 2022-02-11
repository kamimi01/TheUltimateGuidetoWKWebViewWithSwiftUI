//
//  WebViewModel.swift
//  OpeningALinkInTheExternalBrowser
//
//  Created by Mika Urakawa on 2022/02/11.
//

import Foundation

class WebViewModel: ObservableObject {
    @Published var isShownAlert = false
    @Published var alertTitle = ""
}
