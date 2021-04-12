//
//  ReviewListSection.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 11/04/2021.
//

import SwiftUI

struct ReviewListSection: View {
    @ObservedObject var viewModel: TeacherViewModel
    @Binding var selectedLab: UInt64
    var enrollmentLinks: [EnrollmentLink]
    var heading: String
    
    var body: some View {
        Section(header: Text("\(heading) (\(enrollmentLinks.count))")){
            ForEach(enrollmentLinks, id: \.self){ link in
                NavigationLink(destination: SubmissionReview(user: link.enrollment.user, viewModel: viewModel, submissionLink: submissionForSelectedLab(links: link.submissions)!)){
                    VStack{
                        SubmissionListItem(submitterName: link.enrollment.user.name, subLink: submissionForSelectedLab(links: link.submissions)!)
                        Divider()
                    }
                }
            }
        }
    }
    
    func submissionForSelectedLab(links: [SubmissionLink]) -> SubmissionLink? {
        return links.first(where: {
            $0.assignment.id == self.selectedLab
        })
    }
}

