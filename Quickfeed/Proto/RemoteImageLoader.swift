//
//  RemoteImageLoader.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 11/03/2021.
//

import Foundation

class RemoteImageLoader: ObservableObject {
    public enum State {
        case success, failure
    }
    
    var data = Data()
    var state = State.failure

    init(url: String) {
        guard let parsedURL = URL(string: url) else {
            fatalError("Invalid URL: \(url)")
        }
        
        URLSession(configuration: URLSessionConfiguration.ephemeral).dataTask(with: parsedURL) { data, _, error in
            if let data = data, data.count > 0 {
                self.data = data
                self.state = .success
            }

            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }.resume()
    }
}
