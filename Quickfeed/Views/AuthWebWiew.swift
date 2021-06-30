//
//  AuthWebWiew.swift
//  Quickfeed
//
//  WebView in SwiftUI: https://stackoverflow.com/questions/62962063/implement-webkit-with-swiftui-on-macos-and-create-a-preview-of-a-webpage
//

import SwiftUI
import WebKit
import Combine
import Foundation
import AppKit

struct AuthWebView: View {
    @ObservedObject var viewModel: UserViewModel
    @ObservedObject var webViewModel: WebViewModel
    @Binding var signingIn: Bool

    init(viewModel: UserViewModel, mesgURL: String, signingIn: Binding<Bool>) {
        self.viewModel = viewModel
        self.webViewModel = WebViewModel(link: mesgURL)
        self._signingIn = signingIn
    }
    
    var body: some View {
        SwiftUIWebView(viewModel: webViewModel)
            .onChange(of: webViewModel.link, perform: { value in
                print(webViewModel.pageTitle)
                if let sessionString = webViewModel.siteData["session"] as? String{
                    viewModel.setUser(sessionId: sessionString)
                    print("test")
                    signingIn = false
                }
            })
    }
}


class WebViewModel: ObservableObject {
    @Published var siteData: [String : Any]
    @Published var link: String
    @Published var didFinishLoading: Bool = false
    @Published var pageTitle: String
    
    init (link: String) {
        self.link = link
        self.pageTitle = ""
        self.siteData = [:]
    }
}
/*
class Cookie{
    let Created: Int
    let Domain: String
    let Expires: Date
    let HttpOnly: Bool
    let Name: String
    let Path: String
    let Secure: Bool
    let Value: String
    init(opt: AnyObject) {
        self.Created = opt.getAttribute("Created")
    }
}
*/
struct SwiftUIWebView: NSViewRepresentable {
    
    public typealias NSViewType = WKWebView
    @ObservedObject var viewModel: WebViewModel

    private let webView: WKWebView = WKWebView()
    public func makeNSView(context: NSViewRepresentableContext<SwiftUIWebView>) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator as? WKUIDelegate
        webView.load(Foundation.URLRequest(url: URL(string: viewModel.link)!))
        return webView
    }

    public func updateNSView(_ nsView: WKWebView, context: NSViewRepresentableContext<SwiftUIWebView>) { }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(viewModel)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        private var viewModel: WebViewModel

        init(_ viewModel: WebViewModel) {
           //Initialise the WebViewModel
           self.viewModel = viewModel
        }
        
        public func webView(_: WKWebView, didFail: WKNavigation!, withError: Error) { }

        public func webView(_: WKWebView, didFailProvisionalNavigation: WKNavigation!, withError: Error) { }

        //After the webpage is loaded, assign the data in WebViewModel class
        public func webView(_ web: WKWebView, didFinish: WKNavigation!) {
            self.viewModel.pageTitle = web.title!
            self.viewModel.link = web.url!.absoluteString
            self.viewModel.didFinishLoading = true
            web.getCookies(for: "uis.itest.run"){data in
                self.viewModel.siteData = data
            }
            
            
        }

        public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) { }

        public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
            decisionHandler(.allow)
        }

    }

}




extension WKWebView {

    private var httpCookieStore: WKHTTPCookieStore  { return WKWebsiteDataStore.default().httpCookieStore }

    func getCookies(for domain: String? = nil, completion: @escaping ([String : String])->())  {
        var cookieDict = [String : String]()
        httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                if let domain = domain {
                    if cookie.domain.contains(domain) {
                        cookieDict[cookie.name] = cookie.value as String?
                    }
                } else {
                    cookieDict[cookie.name] = cookie.value as String?
                }
            }
            completion(cookieDict)
        }
    }
}
