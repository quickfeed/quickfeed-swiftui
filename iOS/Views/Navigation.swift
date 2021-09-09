//
//  Navigation.swift
//  QuickFeed (iOS)
//
//  Created by Bjørn Kristian Teisrud on 01/08/2021.
//

import SwiftUI

struct Navigation: View {
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        TabView{
            if !viewModel.courses.isEmpty {
                CourseNavigation(viewModel: viewModel, selectedCourse: viewModel.courses[0].id)
                    .tabItem {
                        Label("Assignments", systemImage: "square.and.pencil")
                    }
            }
            if viewModel.user!.isAdmin {
                AdminCourses(viewModel: AdminViewModel.shared)
                    .tabItem {
                        Label("Courses", systemImage: "folder")
                    }
                AdminUsers(viewModel: AdminViewModel.shared)
                    .tabItem {
                        Label("Users", systemImage: "person.3")
                    }
            }
            UserProfile(viewModel: viewModel)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}
