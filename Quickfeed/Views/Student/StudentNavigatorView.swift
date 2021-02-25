//
//  StudentNavigatorView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 25/01/2021.
//

import SwiftUI

struct StudentNavigatorView: View {
    @StateObject var viewModel: StudentViewModel
    @State var selectedCourse: UInt64
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                List{
                    CoursePicker(courses: viewModel.courses, selectedCourse: $selectedCourse)
                    LabSection(assignments: viewModel.getAssignments(courseID: selectedCourse))
                    GithubLinkSection(orgUrl: "https://github.com/dat310-spring21", isTeacher: false)
                    
                }
                Spacer()
                HStack{
                    Image(systemName: "person.fill")
                    Text("Bjørn Kristian Teisrud")
                }
                .padding()
            }
        }
    }
}

struct StudentNavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        StudentNavigatorView(viewModel: StudentViewModel(provider: FakeProvider()), selectedCourse: 111)
    }
}
