//
//  Admin.swift
//  Quickfeed
//

import SwiftUI

struct Admin: View {
    @ObservedObject var viewModel: AdminViewModel
    @State var showUsers: Bool = true
    
    var body: some View {
        if showUsers {
            AdminUsers(viewModel: viewModel)
        } else {
            AdminCourses(viewModel: viewModel, showUsers: $showUsers)
        }
    }
}
