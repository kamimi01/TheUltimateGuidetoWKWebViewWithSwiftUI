//
//  DialogManager.swift
//  ShowingCustomUI
//
//  Created by mikaurakawa on 2022/12/11.
//

import Foundation

class DialogManager: ObservableObject {
    // アラートダイアログ
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var alertCompletion: () -> Void = {}

    // 確認ダイアログ
    @Published var showConfirmAlert = false
    @Published var confirmMessage = ""
    @Published var confirmCompletion: (Bool) -> Void = { _ in }

    // プロンプト
    @Published var showPromptAlert = false
    @Published var promptDefaultText = ""
    @Published var promptMessage = ""
    @Published var promptCompletion: (String?) -> Void = { _ in}
}
