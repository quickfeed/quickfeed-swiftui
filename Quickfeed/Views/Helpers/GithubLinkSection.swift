//
//  GithubLinkSection.swift
//  Quickfeed
//

import SwiftUI

struct GithubLinkSection: View {
    var orgPath: String
    var userLogin: String
    var group: Group?
    var isTeacher: Bool
    
    var body: some View {
        Section(header: Text("Repositories")){
            Link("\(userLogin)-labs", destination: URL(string: "https://github.com/" + orgPath + "/" + userLogin + "-labs")!)
            if group != nil {
                Link("\(group!.name)", destination: URL(string: "https://github.com/" + orgPath + "/" + group!.name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)!)
            }
            Link("course-info", destination: URL(string: "https://github.com/" + orgPath + "/course-info")!)
            Link("assignments", destination: URL(string: "https://github.com/" + orgPath + "/assignments")!)
            if isTeacher{
                Link("tests", destination: URL(string: "https://github.com/" + orgPath + "/tests")!)
            }
        }
    }
}
