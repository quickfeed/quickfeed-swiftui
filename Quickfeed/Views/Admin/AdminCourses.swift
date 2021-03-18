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
    @State var editCourse: Bool = false
    
    var body: some View {
        if !editCourse {
            AllCourses(viewModel: viewModel, showUsers: $showUsers, editCourse: $editCourse)
        } else {
            NewOrEditCourse()
        }
    }
}

/*struct AdminCourses_Previews: PreviewProvider {
    static var previews: some View {
        AdminCourses()
    }
}*/
