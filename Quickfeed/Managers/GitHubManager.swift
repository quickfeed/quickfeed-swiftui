//
//  GitHubManager.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 23/02/2021.
//

import Foundation
import AuthenticationServices

typealias ASPresentationAnchor = NSWindow

class LogInViewModel: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    func logInWithGitHub() {
        guard let authURL = URL(string: "http://172.17.0.1:8080/app/login/login/github") else { return }
        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: nil, completionHandler: { (callbackURL, error) in
                guard error == nil, let callbackURL = callbackURL else { return }
            
                let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
                let tempCode = queryItems?.filter({ $0.name == "code" }).first?.value
            
                //self.getAccessToken(authCode: tempCode!)
        })
        session.prefersEphemeralWebBrowserSession = false
        session.presentationContextProvider = self
        session.start()
    }
}
