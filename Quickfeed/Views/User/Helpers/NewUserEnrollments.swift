//
//  NewUserEnrollments.swift
//  Quickfeed
//

import SwiftUI

struct NewUserEnrollments: View {
    @ObservedObject var viewModel: UserViewModel
    @State private var newEnrollments: Bool = true
    
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
                        Divider()
                    }
                }
                .cornerRadius(10)
                .padding(.horizontal)
            }
        } else {
            VStack(alignment: .leading){
                HStack{
                    if viewModel.enrollments != []{
                        Button(action: { self.newEnrollments = !self.newEnrollments}){
                            Image(systemName: "chevron.backward")
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
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
                .padding(.horizontal)
            }
        }
    }
}

