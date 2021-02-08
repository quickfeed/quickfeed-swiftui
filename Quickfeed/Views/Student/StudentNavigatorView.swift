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
            VStack{
                List{
                    CoursePicker(courses: viewModel.courses, selectedCourse: $selectedCourse)
                    LabSection(labs: viewModel.getAssignments(courseID: selectedCourse), isTeacher: false)
                }
                Spacer()
            }
        }
    }
}

struct StudentNavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        StudentNavigatorView(viewModel: StudentViewModel(provider: FakeProvider()), selectedCourse: 111)
    }
}
