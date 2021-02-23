//
//  ResultView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 23/02/2021.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var viewModel: TeacherViewModel
    @Binding var selectedCourse: UInt64
    @State var users: [User] = []
    @State var searchQuery: String = ""
    @State private var displayingSubmission = false
    
    var body: some View {
        
        if !displayingSubmission {
            ResultGrid(displayingSubmission: $displayingSubmission, selectedCourse: $selectedCourse)
        }
        if displayingSubmission {
            // SubmissionResults(show: $show)
            VStack{
                Text("test")
            }
                
        }
    
        
        
        
    }
    
    
    
}

struct ResultGridView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(selectedCourse: .constant(111))
            .environmentObject(TeacherViewModel(provider: FakeProvider()))
    }
}
