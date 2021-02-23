//
//  GitHubManager.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 23/02/2021.
//

import Foundation
import AuthenticationServices

typealias ASPresentationAnchor = NSWindow

struct GitHubConstants {
    static let CLIENT_ID = "7dc199d467863a0e88b1"
    static let CLIENT_SECRET = "16f9cb941aa55ffea6209ba106831edb70b20acc"
    static let REDIRECT_URI = "Quickfeed://"
    static let SCOPE = "read:user"
    static let TOKENURL = "https://github.com/login/oauth/access_token"
}

class LogInViewModel: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    func logInWithGitHub() {
        guard let authURL = URL(string: "https://github.com/login/oauth/authorize?client_id=" + GitHubConstants.CLIENT_ID + "&scope=" + GitHubConstants.SCOPE + "&redirect_uri=" + GitHubConstants.REDIRECT_URI + "&state=" + UUID().uuidString) else { return }
        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: GitHubConstants.REDIRECT_URI, completionHandler: { (callbackURL, error) in
                guard error == nil, let callbackURL = callbackURL else { return }
            
                let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
                let code = queryItems?.filter({ $0.name == "code" }).first?.value
                //self.githubRequestForAccessToken(authCode: code!)
        })
        session.presentationContextProvider = self
        session.start()
    }
}
