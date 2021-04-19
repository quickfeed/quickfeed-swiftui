//
//  NewUserProfile.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 14/04/2021.
//

import SwiftUI

struct NewUserProfile: View {
    @ObservedObject var viewModel: UserViewModel

    var body: some View {
        HStack{
            UserInformation(viewModel: viewModel)
            VStack(alignment: .leading){
                HStack{
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
                            }){
                                Text("Enroll")
                            }
                        }
                        Divider()
                    }
                }
            }
        }
    }
}
