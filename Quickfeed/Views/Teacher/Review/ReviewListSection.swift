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
    @State var enrollmentLinks: [EnrollmentLink]
    var heading: String
    
    var body: some View {
        Section(header: Text("\(heading) (\(enrollmentLinks.count))")){
            ForEach(enrollmentLinks, id: \.self){ link in
                NavigationLink(destination: SubmissionReview(viewModel: viewModel, submissionLink: submissionForSelectedLab(links: link.submissions)!, user: link.enrollment.user)){
                    VStack{
                        SubmissionListItem(submitterName: link.enrollment.user.name, subLink: submissionForSelectedLab(links: link.submissions)!)
                            .environmentObject(viewModel)
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
    
    func getReviewerName(link: EnrollmentLink) -> String{
        let sublink = submissionForSelectedLab(links: link.submissions)
        if ((sublink?.hasSubmission) != nil){
            if sublink!.submission.reviews.count > 0{
                return viewModel.getUserName(userId: sublink?.submission.reviews[0].reviewerID ?? 100)
            }
        }
        return "unknown reviewer"
    }
}

