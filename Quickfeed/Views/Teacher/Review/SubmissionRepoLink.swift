//
//  SubmissionRepoLink.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 19/04/2021.
//

import SwiftUI

struct SubmissionRepoLink: View {
    var submissionLink: SubmissionLink
    var orgPath: String
    var user: User
    var body: some View {
        HStack{
            Link(destination: URL(string: "https://www.github.com/" + orgPath + "/" + user.login + "-labs")!, label:{
                Text(user.login + "/" + submissionLink.assignment.name)
            })
            Button(action: { setClipboardString(userLogin: user.login) }, label: {
                Image(systemName: "doc.on.doc")
                    .padding()
            })
            .buttonStyle(PlainButtonStyle())
            .help("Copy repo name to clipboard")
        }
    }
    
    func setClipboardString(userLogin: String){
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
        pasteboard.setString(userLogin + "-labs", forType: NSPasteboard.PasteboardType.string)
    }
}
