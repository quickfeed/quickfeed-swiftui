//
//  GitHubManager.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 23/02/2021.
//

import Foundation
import AuthenticationServices

struct GithubConstants {
    
    static let CLIENT_ID = "346a971eb8e99da32318"
    static let CLIENT_SECRET = "ddeb48be1796c3ea996bb24013a7819ff409ee5b"
    static let REDIRECT_URI = "quickfeed://oauth-callback"
    static let SCOPE = ""
    static let TOKENURL = "https://github.com/login/oauth/access_token"
    
}

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
        guard let authURL = URL(string: "https://github.com/login/oauth/authorize?client_id=" + GithubConstants.CLIENT_ID + "&scope=" + GithubConstants.SCOPE + "&redirect_uri=" + GithubConstants.REDIRECT_URI + "&state=" + UUID().uuidString) else { return }
        //guard let authURL = URL(string: "http://172.17.0.1:8080/app/login/login/github") else { return }
        //guard let authURL = URL(string: "http://127.0.0.1:8081/app/login/login/github") else { return }
        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: "quickfeed", completionHandler: { (callbackURL, error) in
            //guard error == nil, let callbackURL = callbackURL else { return }
            guard error == nil else { return }
            
            DispatchQueue.main.async {
                self.viewModel.setUser(userID: 78)
            }
        })
        
        session.prefersEphemeralWebBrowserSession = false
        session.presentationContextProvider = self
        session.start()
    }
}
