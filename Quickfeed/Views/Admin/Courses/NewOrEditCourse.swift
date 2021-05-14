//
//  NewOrEditCourse.swift
//  Quickfeed
//

import SwiftUI

struct NewOrEditCourse: View {
    @ObservedObject var viewModel: AdminViewModel
    var course: Course?
    @Binding var editCourse: Bool
    @State var validOrg: Bool = false
    @State var organization: String = ""
    var orgUrl: String { return "https://github.com/organizations/\(organization)/settings/oauth_application_policy" }
    @State private var showingAlert = false
    @Environment(\.openURL) var openURL
    
    var body: some View {
        if course == nil{
            Text("Create New Course at QuickFeed")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            ScrollView{
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
                    
                }
                .frame(minWidth: 650, minHeight: 170)
                Form{
                    Text("GitHub Organization Name:")
                        .bold()
                    TextField("Enter Organization Name...", text: $organization)
                        .disabled(validOrg)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 400)
                        .padding(.leading)
                    if !validOrg {
                        HStack{
                            Button(action: {
                                if viewModel.getOrganization(orgName: organization) {
                                    validOrg = true
                                    showingAlert = false
                                } else {
                                    validOrg = false
                                    showingAlert = true
                                }
                                //showingAlert = true
                                //validOrg = true
                            }, label: {
                                Text("Connect Organization")
                            })
                            .alert(isPresented:$showingAlert) {
                                Alert(
                                    title: Text("An Error Occurred"),
                                    message: Text("Your github organization must allow Third-party application access policy"),
                                    primaryButton: .default(Text("Redirect to Organization")) {
                                        openURL(URL(string: orgUrl)!)
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                        }
                    } else {
                        CourseFields(viewModel: viewModel, course: course)
                    }
                }
                Spacer()
            }
            .frame(minHeight: 200)
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
            Text("Edit Course: \(course!.code)")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Text(course!.name)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom)
            Form{
                CourseFields(viewModel: viewModel, course: course)
            }
            .frame(minWidth: 450)
            Spacer()
                .navigationTitle("Edit Course")
                .navigationSubtitle("\(course!.code): \(course!.name)")
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
