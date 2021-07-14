//
//  UserEnrollments.swift
//  Quickfeed
//

import SwiftUI

struct UserEnrollments: View {
    @ObservedObject var viewModel: UserViewModel
    @Binding var selectedCourse: UInt64
    @State private var newEnrollments: Bool = false
    
    func sortCourseByCode() -> [Course] {
        var courses = viewModel.getCourses()!
        courses.sort { $0.code < $1.code }
        return courses
    }
    
    var body: some View {
        if !newEnrollments {
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                    Text("Enrollments")
                        .font(.title2)
                        .bold()
                    
                    Spacer()
                    Button(action: {
                        self.newEnrollments = !self.newEnrollments
                    }){
                        Image(systemName: "plus")
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                List{
                    ForEach(viewModel.enrollments, id: \.self){ enrollment in
                        HStack{
                            Text(viewModel.getCourseById(courseId: enrollment.courseID).code)
                                .frame(width: 60, alignment: .leading)
                            Text(viewModel.getCourseById(courseId: enrollment.courseID).name)
                            Spacer()
                            Text(translateUserStatus(status: enrollment.status))
                        }
                        .onTapGesture {
                            if enrollment.status == Enrollment.UserStatus.student || enrollment.status == Enrollment.UserStatus.teacher {
                                self.selectedCourse = enrollment.courseID
                            }
                        }
                        Divider()
                    }
                }
                .cornerRadius(10)
                .padding(.horizontal)
            }
        } else {
            VStack(alignment: .leading){
                HStack{
                    Button(action: { self.newEnrollments = !self.newEnrollments}){
                        Image(systemName: "chevron.backward")
                    }
                    .buttonStyle(PlainButtonStyle())
                    Spacer()
                    Text("New Enrollments")
                        .font(.title2)
                        .bold()
                    
                    Spacer()
                }
                List{
                    ForEach(viewModel.sortCourseByCode(courses: viewModel.getCoursesForNewEnrollments()!), id: \.self){ course in
                        HStack{
                            Text(course.code)
                                .frame(width: 60, alignment: .leading)
                            Text(course.name)
                            Spacer()
                            Button(action: {
                                viewModel.createEnrollment(courseID: course.id)
                                self.newEnrollments = false
                            }){
                                Text("Enroll")
                            }
                        }
                        Divider()
                    }
                }
                .cornerRadius(10)
                .padding(.trailing)
            }
        }
    }
}
