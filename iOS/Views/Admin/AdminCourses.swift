//
//  AdminCourses.swift
//  QuickFeed (iOS)
//
//  Created by Bjørn Kristian Teisrud on 09/09/2021.
//

import SwiftUI

struct AdminCourses: View {
    @ObservedObject var viewModel: AdminViewModel
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Course")){
                    List{
                        ForEach(self.filteredCourses(), id: \.self){ course in
                            NavigationLink(destination: AdminCourseProfile(viewModel: viewModel, course: course)){
                                Text(course.code)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Manage Courses")
            .toolbar {
                Button(action: {}){
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    func filteredCourses() -> [Course] {
        var course = viewModel.courses
        course.sort { $0.code < $1.code }
        return course
    }
}
