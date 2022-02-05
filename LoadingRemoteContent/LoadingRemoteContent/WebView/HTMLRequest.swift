//
//  HTMLRequest.swift
//  LoadingRemoteContent
//
//  Created by Mika Urakawa on 2022/02/04.
//

import Foundation

class HTMLRequest {
    let baseURL = URL(string: "http://localhost:3000")!
    let method = "POST"
    let headers: [String: String] = ["Content-Type": "application/x-www-form-urlencoded"]
    var parameters = [String: String]()

    init(parameters: [String: String]) {
        self.parameters = parameters
    }

    func buildURLRequest() -> URLRequest {
        var urlRequest = URLRequest(url: baseURL)
        urlRequest.httpMethod = method
        headers.forEach { key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        var components = URLComponents()
        components.queryItems = [URLQueryItem]()
        parameters.forEach {
            components.queryItems?.append(
                URLQueryItem(name: $0.key, value: $0.value)
            )
        }
        urlRequest.httpBody = components.query?.data(using: .utf8)
        return urlRequest
    }
}
