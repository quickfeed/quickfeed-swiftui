//
//  GithubLinkSection.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 07/02/2021.
//

import SwiftUI

struct GithubLinkSection: View {
    var orgUrl: String
    var isTeacher: Bool
    var body: some View {
        Section(header: Text("Repositories")){
            Link("course-info", destination: URL(string: orgUrl + "/course-info")!)
            Link("assignments", destination: URL(string: orgUrl + "/assignments")!)
            if isTeacher{
                Link("tests", destination: URL(string: orgUrl + "/tests")!)
            }
            
        }
    }
}

struct GithubLinkSection_Previews: PreviewProvider {
    static var previews: some View {
        List{
            GithubLinkSection(orgUrl: "https://github.com/dat310-spring21", isTeacher: true)
                
            
        }
        .previewDisplayName("Teacher")
        
        List{
            GithubLinkSection(orgUrl: "https://github.com/dat310-spring21", isTeacher: false)
                
        }
        .previewDisplayName("Student")
        .preferredColorScheme(.light)
        
        
    }
}
