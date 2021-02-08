//
//  StudentNavigatorView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 25/01/2021.
//

import SwiftUI

struct StudentNavigatorView: View {
    var student: UserModel
    var courses: [CourseModel]
    @State private var selectedCourse = 1

    var body: some View {
        NavigationView{
            List{
                Text("Course")
                Picker(selection: $selectedCourse, label: Text("Current course")) {
                    ForEach(courses, id: \.id){ course in
                        NavigationLink(destination: Text(course.code)){
                            Text(course.code)
                        }
                    }
                }
                .padding(.leading)
                .pickerStyle(MenuPickerStyle())
                .labelsHidden()
                
                Text("Labs")
                StudentLabMenu(selectedCourse: selectedCourse, labs: AssignmentModel.data)
                    .padding(.leading)
            }
            .frame(minWidth: 170)
        }
    }
}

struct StudentNavigatorView_Previews: PreviewProvider {
    static var student = UserModel.data[0]
    static var coures = CourseModel.data
    static var previews: some View {
        StudentNavigatorView(student: student, courses: coures)
    }
}
