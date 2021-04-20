//
//  ResultView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 23/02/2021.
//

import SwiftUI

struct ResultView: View {
    @ObservedObject var viewModel: TeacherViewModel
    @State var searchQuery: String = ""
    @State private var displayedSubmissionLink: SubmissionLink? = nil
    
    var body: some View {
        VStack{
            if displayedSubmissionLink == nil {
                ResultGrid(viewModel: viewModel, displayedSubmissionLink: $displayedSubmissionLink)
            }
            if displayedSubmissionLink != nil {
                // SubmissionResults(show: $show)
                SubmissionResult(viewModel: viewModel, displayedSubmissionLink: $displayedSubmissionLink)
                
            }
        }
        .onAppear(perform: {
            viewModel.loadEnrollmentLinks()
        })
        .navigationTitle("Results")
        
        .navigationSubtitle(viewModel.currentCourse.name)
       
    }
}


