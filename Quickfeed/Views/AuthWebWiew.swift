//
//  AuthWebWiew.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 25/06/2021.
//

import SwiftUI
import WebKit
import Combine
import Foundation
import AppKit

struct AuthWebView: View {
    @ObservedObject var model: WebViewModel

    init(mesgURL: String) {
        //Assign the url to the model and initialise the model
        self.model = WebViewModel(link: mesgURL)
    }
    
    var body: some View {
        //Create the WebView with the model
        SwiftUIWebView(viewModel: model)
            .onChange(of: model.pageTitle, perform: { value in
                print(model.sitedata)
                
            })
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
           //Initialise the WebViewModel
           self.viewModel = viewModel
        }
        
        public func webView(_: WKWebView, didFail: WKNavigation!, withError: Error) { }

        public func webView(_: WKWebView, didFailProvisionalNavigation: WKNavigation!, withError: Error) { }

        //After the webpage is loaded, assign the data in WebViewModel class
        public func webView(_ web: WKWebView, didFinish: WKNavigation!) {
            self.viewModel.pageTitle = web.title!
            self.viewModel.link = web.url?.absoluteString as! String
            self.viewModel.didFinishLoading = true
            web.getCookies(for: "uis.itest.run"){data in
                self.viewModel.sitedata = data
                print(data)
            }
            
            
        }

        public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) { }

        public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(.allow)
        }

    }

}


class WebViewModel: ObservableObject {
    @Published var sitedata: [String : Any]
    @Published var link: String
    @Published var didFinishLoading: Bool = false
    @Published var pageTitle: String
    
    init (link: String) {
        self.link = link
        self.pageTitle = ""
        self.sitedata = [:]
    }
}

extension WKWebView {

    private var httpCookieStore: WKHTTPCookieStore  { return WKWebsiteDataStore.default().httpCookieStore }

    func getCookies(for domain: String? = nil, completion: @escaping ([String : Any])->())  {
        var cookieDict = [String : AnyObject]()
        httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                if let domain = domain {
                    if cookie.domain.contains(domain) {
                        cookieDict[cookie.name] = cookie.properties as AnyObject?
                    }
                } else {
                    cookieDict[cookie.name] = cookie.properties as AnyObject?
                }
            }
            completion(cookieDict)
        }
    }
}
