//
//  Admin.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 17/03/2021.
//

import SwiftUI

struct Admin: View {
    @ObservedObject var viewModel: AdminViewModel
    @State var showUsers: Bool = true
    var body: some View {
        if showUsers {
            AdminUsers(viewModel: viewModel, showUsers: $showUsers)
        } else {
            AdminCourses(viewModel: viewModel, showUsers: $showUsers)
        }
    }
}

/*struct Admin_Previews: PreviewProvider {
    static var previews: some View {
        Admin()
    }
}*/
