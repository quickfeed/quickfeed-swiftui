//
//  CourseNavigation.swift
//  QuickFeed (iOS)
//
//  Created by Bjørn Kristian Teisrud on 01/08/2021.
//

import SwiftUI

struct CourseNavigation: View {
    @ObservedObject var viewModel: UserViewModel
    @State var selectedCourse: UInt64
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Select Course")) {
                    Picker("Course", selection: $selectedCourse) {
                        ForEach(viewModel.courses, id: \.id) {
                            Text($0.code)
                        }
                    }
                    if viewModel.getCourseById(courseId: selectedCourse).slipDays != 0 && viewModel.getCourse(courseID: selectedCourse)!.enrolled == Enrollment.UserStatus.student {
                        Text("SlipDays: \(viewModel.getEnrollmentByCourse(courseID: selectedCourse)!.slipDaysRemaining)")
                    }
                }
                if viewModel.getCourse(courseID: selectedCourse)!.enrolled == Enrollment.UserStatus.student {
                    StudentNavigation(viewModel: StudentViewModel(course: viewModel.getCourseById(courseId: selectedCourse)))
                } else {
                    Text("Teacher")
                }
            }
            .navigationTitle("\(viewModel.getCourse(courseID: selectedCourse)!.code)")
        }
    }
}
