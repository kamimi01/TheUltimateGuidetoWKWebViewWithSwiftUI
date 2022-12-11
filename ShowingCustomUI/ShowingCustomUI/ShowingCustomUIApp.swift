//
//  ShowingCustomUIApp.swift
//  ShowingCustomUI
//
//  Created by mikaurakawa on 2022/12/11.
//

import SwiftUI

@main
struct ShowingCustomUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DialogManager())
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let config = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        config.delegateClass = SceneDelegate.self
        return config
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    lazy var dialogManager = DialogManager()
    var keyWindow: UIWindow?
    var dialogWindow: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            setupKeyWindow(in: windowScene)
            setupDialogWindow(in: windowScene)
        }
    }

    private func setupKeyWindow(in scene: UIWindowScene) {
        let window = UIWindow(windowScene: scene)
        window.rootViewController = UIHostingController(rootView: ContentView().environmentObject(dialogManager))
        self.keyWindow = window
        window.makeKeyAndVisible()
    }

    private func setupDialogWindow(in scene: UIWindowScene) {
        let dialogWindow = DialogWindow(windowScene: scene)
        let dialogWindowController = UIHostingController(rootView: DialogView().environmentObject(dialogManager))
        dialogWindowController.view.backgroundColor = .clear  // クリアにしないとkeyWindowがdialogWindowにかぶさってしまう
        dialogWindow.rootViewController = dialogWindowController
        dialogWindow.isHidden = false  // makeKeyAndVisible()を呼ばない代わりに、falseにして確実に表示
        self.dialogWindow = dialogWindow
    }
}
