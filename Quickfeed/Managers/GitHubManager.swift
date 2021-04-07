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
    static let REDIRECT_URI = "Quickfeed"
    static let SCOPE = "read:user"
    static let TOKENURL = "https://github.com/login/oauth/access_token"
}

class LogInViewModel: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    func logInWithGitHub() {
        guard let authURL = URL(string: "https://github.com/login/oauth/authorize?client_id=" + GitHubConstants.CLIENT_ID + "&scope=" + GitHubConstants.SCOPE + "&redirect_uri=" + GitHubConstants.REDIRECT_URI + "://&state=" + UUID().uuidString) else { return }
        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: GitHubConstants.REDIRECT_URI, completionHandler: { (callbackURL, error) in
                guard error == nil, let callbackURL = callbackURL else { return }
            
                let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
                let tempCode = queryItems?.filter({ $0.name == "code" }).first?.value
            
                self.getAccessToken(authCode: tempCode!)
        })
        session.prefersEphemeralWebBrowserSession = false
        session.presentationContextProvider = self
        session.start()
    }
    
    func getAccessToken(authCode: String) {
        let postParams = ("grant_type=authorization_code&code=" + authCode + "&client_id=" + GitHubConstants.CLIENT_ID + "&client_secret=" + GitHubConstants.CLIENT_SECRET).data(using: String.Encoding.utf8)
        
        var request = Foundation.URLRequest(url: URL(string: GitHubConstants.TOKENURL)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = postParams
        
        URLSession(configuration: URLSessionConfiguration.ephemeral).dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data, let response = response, error == nil else { return }
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 200 {
                let results = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [AnyHashable: Any]
                let accessToken = results?["access_token"] as! String
                
                self.getGitHubProfile(accessToken: accessToken)
            } else {
                return
            }
        }).resume()
    }
    
    func getGitHubProfile(accessToken: String) {
        var request = Foundation.URLRequest(url: URL(string: "https://api.github.com/user")!)
        request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        
        URLSession(configuration: URLSessionConfiguration.ephemeral).dataTask(with: request, completionHandler: { (data, _, error) in
            guard let data = data, error == nil else { return }
            let result = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [AnyHashable: Any]
            print("Access Token: \(accessToken)")
            
            let githubId: Int! = (result?["id"] as! Int)
            print("Id: \(githubId ?? 0)")
            
            let githubDisplayName: String! = (result?["login"] as! String)
            print("Name: \(githubDisplayName ?? "")")
            
            let githubAvatarURL: String! = (result?["avatar_url"] as! String)
            print("Avatar URL: \(githubAvatarURL ?? "")")
        }).resume()
    }
}
