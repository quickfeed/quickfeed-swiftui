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
    @State var displayedAssignment: Assignment? = nil
    @State var isShowingSheet: Bool = false
    
    var body: some View {
        List{
            ForEach(viewModel.assignments, id: \.self){ assignment in
                HStack{
                    Text("\(assignment.name)")
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    displayedAssignment = assignment
                    isShowingSheet.toggle()
                }
                Divider()
            }
        }
        .frame(minWidth: 400, minHeight: 200)
        .sheet(isPresented: $isShowingSheet, onDismiss: dismissSheet, content: {
            VStack {
                HStack{
                    Spacer()
                    Button(action: {isShowingSheet.toggle()}, label: {
                        Image(systemName: "multiply")
                            .font(.title)
                    })
                    .padding()
                    .help("esc")
                    .buttonStyle(PlainButtonStyle())
                }
                AssignmentView(viewModel: viewModel, assignment: $displayedAssignment)
            }
            .frame(minWidth: 700, minHeight: 700)
            .onKeyboardShortcut(.escape, perform: {
                if isShowingSheet{
                    isShowingSheet.toggle()
                }
            })
        })
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
    func dismissSheet() {
        return
    }
}
