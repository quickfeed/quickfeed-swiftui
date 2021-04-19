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

class LogInViewModel: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    func logInWithGitHub() {
        var test = "https://github.com/login/oauth/authorize?client_id=" + GithubConstants.CLIENT_ID + "&scope=" + GithubConstants.SCOPE + "&redirect_uri=" + GithubConstants.REDIRECT_URI + "&state=" + UUID().uuidString
        //guard let authURL = URL(string: "http://172.17.0.1:8080/app/login/login/github") else { return }
        guard let authURL = URL(string: "http://127.0.0.1:8081/app/login/login/github") else { return }
        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: "quickfeed", completionHandler: { (callbackURL, error) in
            guard error == nil, let callbackURL = callbackURL else { return }
            
            let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
            let tempCode = queryItems?.filter({ $0.name == "code" }).first?.value

            
            print(callbackURL)
            
            //self.getAccessToken(authCode: tempCode!)
        })
        session.prefersEphemeralWebBrowserSession = false
        session.presentationContextProvider = self
        session.start()
    }
}



/*let url = URL(string: "http://www.thisismylink.com/postName.php")!
 var request = URLRequest(url: url)
 request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
 request.httpMethod = "POST"
 let parameters: [String: Any] = [
 "id": 13,
 "name": "Jack & Jill"
 ]
 request.httpBody = parameters.percentEncoded()
 
 let task = URLSession.shared.dataTask(with: request) { data, response, error in
 guard let data = data,
 let response = response as? HTTPURLResponse,
 error == nil else {                                              // check for fundamental networking error
 print("error", error ?? "Unknown error")
 return
 }
 
 guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
 print("statusCode should be 2xx, but is \(response.statusCode)")
 print("response = \(response)")
 return
 }
 
 let responseString = String(data: data, encoding: .utf8)
 print("responseString = \(responseString)")
 }
 
 task.resume()*/
