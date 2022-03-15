//
//  ContentViewModel.swift
//  ReadingAndDeletingCookies
//
//  Created by Mika Urakawa on 2022/03/14.
//

import Foundation

final class ContentViewModel: ObservableObject {
    @Published var result = ""

    func getUserInfo() {
        // 本来ならここで取得できなければreturnすべきだと思うが、今回はサーバーにエラーを返させたかったので、returnしていない
        let cookie = UserDefaults.standard.string(forKey: "authentication")

        let url = URL(string: "http://localhost:3000/user")!
        var request = URLRequest(url: url)
        request.setValue(cookie, forHTTPHeaderField: "Cookie")

        let session = URLSession.shared
        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self,
                  let data = data
            else {
                return
            }
            do {
                let object = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, Any>
                DispatchQueue.main.async {
                    if let userName = object["username"] as? String {
                        self.result = userName
                        return
                    }
                    if let error = object["error"] as? String {
                        self.result = error
                        return
                    }
                }
            } catch {
                print("fail JSONSerialization")
            }
        }
        task.resume()
    }
}
