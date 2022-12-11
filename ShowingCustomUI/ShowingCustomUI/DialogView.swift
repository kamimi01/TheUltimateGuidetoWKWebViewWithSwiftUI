//
//  SwiftUITestView.swift
//  ShowingCustomUI
//
//  Created by mikaurakawa on 2022/12/11.
//

import SwiftUI

struct DialogView: View {
    @EnvironmentObject var dialogManager: DialogManager

    var body: some View {
        EmptyView()
            .alert("Hey, Listen!", isPresented: $dialogManager.showAlert) {
                Button("OK") {
                    dialogManager.alertCompletion()
                }
            } message: {
                Text(dialogManager.alertMessage)
            }
            .alert("Hey, Listen2!", isPresented: $dialogManager.showConfirmAlert) {
                Button("OK") {
                    dialogManager.confirmCompletion(true)
                }
                Button("キャンセル") {
                    dialogManager.confirmCompletion(false)
                }
            } message: {
                Text(dialogManager.confirmMessage)
            }
            .alert("Hey, Listen3!", isPresented: $dialogManager.showPromptAlert) {
                TextField(dialogManager.promptMessage, text: $dialogManager.promptDefaultText)
                Button("OK") {
                    dialogManager.promptDefaultText = ""
                    dialogManager.promptCompletion(dialogManager.promptDefaultText)
                }
                Button("キャンセル") {
                    dialogManager.promptDefaultText = ""
                    dialogManager.promptCompletion(nil)
                }
            } message: {
                Text(dialogManager.promptMessage)
            }
    }
}

struct DialogView_Previews: PreviewProvider {
    static var previews: some View {
        DialogView()
    }
}
