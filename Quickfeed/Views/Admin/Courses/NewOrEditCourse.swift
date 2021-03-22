//
//  NewOrEditCourse.swift
//  Quickfeed
//
//  Created by Bjørn Kristian Teisrud on 18/03/2021.
//

import SwiftUI

struct NewOrEditCourse: View {
    var course: Course?
    @Binding var editCourse: Bool
    @State var organization: String = ""
    
    var body: some View {
        if course == nil{
            VStack(alignment: .leading){
                Text("""
                    For each new semester of a course, QuickFeed requires a new GitHub organization.
                    This is to keep the student roster for the different runs of the course separate.
                    """)
                HStack{
                    Link(destination: URL(string: "https://github.com/account/organizations/new")!, label:{
                        Text("Create an organization for your course.")
                    })
                    Text("The course organization must allow private repositories.")
                }
                Text("QuickFeed will create a following repository structure for you:")
                Text("""
                    - course-info
                    - assignments
                    - tests
                    """)
                    .padding(.leading)
                HStack{
                    Text("Please read")
                    Link(destination: URL(string: "https://github.com/autograde/quickfeed/blob/master/doc/teacher.md")!, label:{
                        Text("the documentation")
                    })
                    Text("for further instructions on how to work with the various repositories.")
                }
                Form{
                    TextField("Enter Organization Name...", text: $organization)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 450)
                    Text("Your Organization: \(organization)")
                }
                
            }
            .padding()
            Spacer()
                .navigationTitle("New Course")
                .toolbar{
                    ToolbarItem(placement: .navigation){
                        
                        Toggle(isOn: $editCourse, label: {
                            Image(systemName: "chevron.backward")
                        })
                        .keyboardShortcut("b")
                        .help("Return to course list")
                    }
                }
                .onDisappear(perform: { self.editCourse = true })
        } else {
            Text("Edit \(course!.code)")
                .navigationTitle("\(course!.code): \(course!.name)")
                .toolbar{
                    ToolbarItem(placement: .navigation){
                        Toggle(isOn: $editCourse, label: {
                            Image(systemName: "chevron.backward")
                        })
                        .keyboardShortcut("b")
                        .help("Return to course list")
                    }
                }
                .onDisappear(perform: { self.editCourse = true })
        }
    }
}

/*struct NewOrEditCourse_Previews: PreviewProvider {
 static var previews: some View {
 NewOrEditCourse()
 }
 }*/
