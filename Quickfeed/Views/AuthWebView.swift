//
//  AuthWebView.swift
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
    @Binding var signedIn: Bool
    
    init(viewModel: UserViewModel, mesgURL: String, signingIn: Binding<Bool>, signedIn: Binding<Bool>) {
        self.viewModel = viewModel
        self.webViewModel = WebViewModel(link: mesgURL)
        self._signingIn = signingIn
        self._signedIn = signedIn
    }
    
    var body: some View {
        VStack{
            SwiftUIWebView(viewModel: webViewModel)
                .onChange(of: webViewModel.link, perform: { value in
                    do{
                        sleep(3)
                    }
                    if let sessionString = webViewModel.siteData["session"] as? String{
                        print(sessionString)
                        viewModel.setUser(sessionId: sessionString)
                        signingIn = false
                        signedIn = true
                        
                    } else {
                        print("Failed to retrieve session")
                    }
                })
        }
    }
}


class WebViewModel: ObservableObject {
    @Published var siteData: [String : Any]
    @Published var link: String
    @Published var didFinishLoading: Bool = false
    @Published var pageTitle: String
    @Published var hasSession: Bool = false
    
    init (link: String) {
        self.link = link
        self.pageTitle = ""
        self.siteData = [:]
    }
}

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
            self.viewModel = viewModel
        }
        
        public func webView(_: WKWebView, didFail: WKNavigation!, withError: Error) { }
        
        public func webView(_: WKWebView, didFailProvisionalNavigation: WKNavigation!, withError: Error) { }
        
        public func webView(_ web: WKWebView, didFinish: WKNavigation!) {
            self.viewModel.pageTitle = web.title!
            self.viewModel.link = web.url!.absoluteString
            self.viewModel.didFinishLoading = true
            web.getCookies(for: CONF_BASE_URL){data in
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
