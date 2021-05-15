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
        self.viewModel.setUser(userID: 7)
        /*guard let authURL = URL(string: "https://QuickFeed.no/auth/github/github") else { return }
        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: "quickfeed", completionHandler: { (callbackURL, error) in
            guard error == nil, let callbackURL = callbackURL else { return }

            let queryItems = URLComponents(string: callbackURL.absoluteString)?
                .queryItems

            let code = queryItems!.first(where: { $0.name == "code" })?.value

            DispatchQueue.main.async {
                self.viewModel.setUser(userID: code)
            }
        })

        session.prefersEphemeralWebBrowserSession = true
        session.presentationContextProvider = self
        session.start()*/
    }
}
