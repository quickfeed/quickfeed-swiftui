//
//  StudentLabOverview.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 28/01/2021.
//

import SwiftUI

struct StudentLabOverview: View {
    var body: some View {
        NavigationView {
            StudentNavigatorView(student: UserModel.data[0], courses: CourseModel.data)
        }

        /*VStack{
            NavigationView {
                Text("Title")
                NavigationLink(destination: NavigationView {
                    LabMenuView(labs: AssignmentModel.data)
                }) {
                    Text("Test")
                }
            }
            .navigationTitle("Title")
            
        }*/
        
    }
}

struct StudentLabOverview_Previews: PreviewProvider {
    static var previews: some View {
        StudentLabOverview()
    }
}
