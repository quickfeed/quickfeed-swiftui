//
//  AssignmentsView.swift
//  Quickfeed
//
//  Created by Oskar Gjølga on 18/04/2021.
//

import SwiftUI

struct AssignmentsView: View {
    @ObservedObject var viewModel: TeacherViewModel
    @State var showingAlert: Bool = false
    var body: some View {
        NavigationView{
            List{
                ForEach(viewModel.assignments, id: \.self){ assignment in
                    NavigationLink(
                        destination: AssignmentView(viewModel: viewModel, assignment: assignment),
                        label: {
                            Text("\(assignment.name)") 
                        })
                    
                    Divider()
                }
            }
        }
        
        .navigationTitle("Assignments")
        .navigationSubtitle(viewModel.currentCourse.name)
        .toolbar{
            ToolbarItem{
                Button(action: {
                    let succeded = viewModel.updateAssignments()
                    if !succeded{
                        showingAlert = true
                    }
                    
                }, label: {
                    Text("Update Course Assignments")
                })
                .alert(isPresented: $showingAlert, content: {
                    Alert(title: Text("Updating Assignments failed"))
                })
            }
        }
    }
}
