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
    @State private var selectedCourse = 0
    
    var body: some View {
        VStack(alignment: .leading){
           
            Picker(selection: $selectedCourse, label: Text("Current course")) {
                ForEach(0 ..< courses.count){
                    Text(courses[$0].code)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .labelsHidden()
            .padding()
                
            LabMenuView(labs: AssignmentModel.data)
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
