//
//  AdminCourses.swift
//  Quickfeed
//

import SwiftUI

struct AdminCourses: View {
    @ObservedObject var viewModel: AdminViewModel
    @State var editCourse: Bool = true
    @State var course: Course?
    
    var body: some View {
        if editCourse {
            AllCourses(viewModel: viewModel, course: $course, editCourse: $editCourse)
        } else {
            NewOrEditCourse(viewModel: viewModel, course: course, editCourse: $editCourse)
        }
    }
}
