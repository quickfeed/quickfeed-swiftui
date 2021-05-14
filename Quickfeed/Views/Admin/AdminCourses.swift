//
//  AdminCourses.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 17/03/2021.
//

import SwiftUI

struct AdminCourses: View {
    @ObservedObject var viewModel: AdminViewModel
    @Binding var showUsers: Bool
    @State var editCourse: Bool = true
    @State var course: Course?
    
    var body: some View {
        if editCourse {
            AllCourses(viewModel: viewModel, showUsers: $showUsers, editCourse: $editCourse, course: $course)
        } else {
            NewOrEditCourse(course: course, editCourse: $editCourse)
        }
    }
}

