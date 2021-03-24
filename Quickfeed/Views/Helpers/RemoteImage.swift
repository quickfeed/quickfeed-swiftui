//
//  RemoteImage.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 23/03/2021.
//

import SwiftUI

struct RemoteImage: View {
    private enum RemoteImageLoadingState {
        case loading, success
    }
    
    private class RemoteImageLoader: ObservableObject {
        var data = Data()
        var state = RemoteImageLoadingState.loading
        
        init(urlString: String) {
            guard let url = URL(string: urlString) else {
                fatalError("Invalid URL: \(urlString)")
            }
            
            URLSession(configuration: .ephemeral).dataTask(with: url) { data, _, _ in
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
    
    @StateObject private var remoteImageLoader: RemoteImageLoader
    var loading: Image = Image(systemName: "person.fill")
    
    init(url: String) {
        _remoteImageLoader = StateObject(wrappedValue: RemoteImageLoader(urlString: url))
    }
    
    var body: some View {
        if remoteImageLoader.state == .success {
            if let image = NSImage(data: remoteImageLoader.data) {
                Image(nsImage: image)
                    .resizable()
            } else {
                loading
                    .resizable()
            }
        } else {
            loading
                .resizable()
        }
    }
}

/*struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage()
    }
}*/
