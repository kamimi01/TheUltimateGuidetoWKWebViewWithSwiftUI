//
//  DialogWindow.swift
//  ShowingCustomUI
//
//  Created by mikaurakawa on 2022/12/11.
//

import Foundation
import UIKit

class DialogWindow: UIWindow {
    // このwindowに対するタップ判定を透過させる
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view == self { return nil }
        if view == rootViewController?.view { return nil }
        return view
    }
}
