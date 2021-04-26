//
//  SubmissionRepoLink.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 19/04/2021.
//

import SwiftUI

struct SubmissionRepoLink: View {
    var assignmentName: String
    var orgPath: String
    var userLogin: String
    var body: some View {
        HStack{
            Link(destination: URL(string: "https://www.github.com/" + orgPath + "/" + userLogin + "-labs")!, label:{
                Text(userLogin + "/" + assignmentName)
            })
            Button(action: { setClipboardString(userLogin: userLogin) }, label: {
                Image(systemName: "doc.on.clipboard.fill")
                    
            })
            .help("Copy repo name to clipboard")
        }
    }
    
    func setClipboardString(userLogin: String){
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
        pasteboard.setString(userLogin + "-labs", forType: NSPasteboard.PasteboardType.string)
    }
}
