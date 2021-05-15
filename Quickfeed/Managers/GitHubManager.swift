//
//  GitHubManager.swift
//  Quickfeed
//

import Foundation
import AuthenticationServices

typealias ASPresentationAnchor = NSWindow

class GitHubManager: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding {
    var viewModel: UserViewModel
    
    init(viewModel: UserViewModel){
        self.viewModel = viewModel
    }
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    func logInWithGitHub() {
        self.viewModel.setUser(userID: 100)
//        guard let authURL = URL(string: "http://127.0.0.1:8081/") else { return }
//        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: "quickfeed", completionHandler: { (callbackURL, error) in
//            //guard error == nil, let callbackURL = callbackURL else { return }
//            guard error == nil else { return }
//
//            DispatchQueue.main.async {
//                self.viewModel.setUser(userID: 100)
//            }
//        })
//
//        session.prefersEphemeralWebBrowserSession = true
//        session.presentationContextProvider = self
//        session.start()
    }
}
